package kr.or.ddit;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.web.util.HtmlUtils;

public class HtmlUnescapeTest {

	@Test
	public void test() {

		System.out.println(HtmlUtils.htmlEscape("<script>"));   // 화면 출력 또는 DB 저장을 할시에

		System.out.println(HtmlUtils.htmlUnescape("<script>"));  // 화면성에서 특정 스크립트를 실행이 가능 하게 처리를 하고 싶을때..

//		System.out.println("======================================");
//
//		System.out.println(HtmlUtils.htmlEscape("<script>"));

//		System.out.println(HtmlUtils.htmlUnescape("&lt;script&gt;"));
//
//		System.out.println("======================================");
//		
//		System.out.println(HtmlUtils.htmlUnescape("&lt;script&gt;"));
//
//		System.out.println(HtmlUtils.htmlEscape("&lt;script&gt;"));
//
//		System.out.println(HtmlUtils.htmlEscape("&")); // & => &amp;
//		System.out.println(HtmlUtils.htmlEscape("&amp;lt;script&amp;gt;"));

//		fail("Not yet implemented");
	}

}
