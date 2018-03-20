package com.syyf.movieMgr.service.captcha;

import java.awt.Color;
import java.util.Random;

import org.patchca.background.SingleColorBackgroundFactory;
import org.patchca.color.SingleColorFactory;
import org.patchca.filter.predefined.CurvesRippleFilterFactory;
import org.patchca.filter.predefined.DiffuseRippleFilterFactory;
import org.patchca.filter.predefined.DoubleRippleFilterFactory;
import org.patchca.filter.predefined.MarbleRippleFilterFactory;
import org.patchca.filter.predefined.WobbleRippleFilterFactory;
import org.patchca.font.RandomFontFactory;
import org.patchca.service.AbstractCaptchaService;
import org.patchca.text.renderer.BestFitTextRenderer;

/**
 * 产生验证码
 */
public class CaptchaService extends AbstractCaptchaService {

	private static final Random random = new Random();
	
	/**
	 * 不可定制的验证码服务(默认)
	 */
	public CaptchaService() {
		
		// 文本内容
		wordFactory = new CaptchaWordFactory();
		
		// 字体
		fontFactory = new RandomFontFactory();
		
		// 效果
		textRenderer = new BestFitTextRenderer();
		
		// 背景
		backgroundFactory = new SingleColorBackgroundFactory();
		
		// 字体颜色
		colorFactory = new SingleColorFactory(new Color(25, 60, 170));
		
		// 样式(曲线波纹加干扰线)
		int i = random.nextInt(5) ;
		switch (i) {
			case 0:
				filterFactory = new CurvesRippleFilterFactory(colorFactory);
				break;
			case 1:
				filterFactory = new DoubleRippleFilterFactory();
				break;
			case 2:
				filterFactory = new WobbleRippleFilterFactory();
				break;
			case 3:
				filterFactory = new DiffuseRippleFilterFactory();
				break;
			case 4:
				filterFactory = new MarbleRippleFilterFactory();
				break;
		}
		
		// 图片宽高
		width = 150;
		height = 50;
	}
	
	/**
	 * 可以定制的验证码服务(宽度和高度)
	 * @param width
	 * @param height
	 */
	public CaptchaService(int width, int height) {
		
		// 文本内容
		wordFactory = new CaptchaWordFactory();
		
		// 字体
		fontFactory = new RandomFontFactory();
		
		// 效果
		textRenderer = new BestFitTextRenderer();
		
		// 背景
		backgroundFactory = new SingleColorBackgroundFactory();
		
		// 字体颜色
		colorFactory = new SingleColorFactory(new Color(25, 60, 170));
		
		// 样式(曲线波纹加干扰线)
		filterFactory = new CurvesRippleFilterFactory(colorFactory);
		
		// 图片宽高
		this.width = width;
		this.height = height;
	}
	
	/**
	 * 可以定制的验证码服务(默认值,宽度和高度)
	 * @param defaultValue
	 * @param width
	 * @param height
	 */
	public CaptchaService(String defaultValue, int width, int height) {
		
		// 文本内容
		wordFactory = new CaptchaWordFactory(defaultValue);
		
		// 字体
		fontFactory = new RandomFontFactory();
		
		// 效果
		textRenderer = new BestFitTextRenderer();
		
		// 背景
		backgroundFactory = new SingleColorBackgroundFactory();
		
		// 字体颜色
		colorFactory = new SingleColorFactory(new Color(25, 60, 170));
		
		// 样式(曲线波纹加干扰线)
		filterFactory = new CurvesRippleFilterFactory(colorFactory);
		
		// 图片宽高
		this.width = width;
		this.height = height;
	}
}