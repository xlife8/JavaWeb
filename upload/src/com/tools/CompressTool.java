package com.tools;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class CompressTool {
	//压缩文件中如果路径是中文的话在windows能正常显示，在linux下会显示乱码
	public static boolean compress(String filePath,String zipFilePath) {
		try {
			File file = new File(filePath);
			File zipFile = new File(zipFilePath);
			ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(zipFile),Charset.forName("gbk"));
			if(file.isDirectory()) {
				File[] files = file.listFiles();
				if(files.length != 0) {
					for(File fileSec:files) {
						recursionZip(zipOut,fileSec,file.getName()+File.separator);
					}
				}
			}
			zipOut.close();
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	private static void recursionZip(ZipOutputStream zipOut,File file,String prefix) throws IOException {
		if(file.isDirectory()) {
			File[] files = file.listFiles();
			if(files.length != 0) {
				for(File fileSec:files) {
					recursionZip(zipOut,fileSec,prefix+file.getName()+File.separator);
				}
			}
		} else {
			byte[] buf = new byte[1024];
			InputStream in =new FileInputStream(file);
			zipOut.putNextEntry(new ZipEntry(prefix+file.getName()));
			int len;
			while((len = in.read(buf)) != -1) {
				zipOut.write(buf, 0, len);
			}
			in.close();
		}
	}
}

