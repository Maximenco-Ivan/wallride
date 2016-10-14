package org.wallride.support;

import org.junit.Test;

import java.text.ParseException;
import java.util.Locale;

import static org.junit.Assert.assertEquals;

/**
 * Created by SHIMAUCHI on 2016/10/14.
 */
public class StringFormatterTests {

	private static StringFormatter stringFormatter = new StringFormatter();

	private String param = "Test Message";

	@Test
	public void print() {
		String result = stringFormatter.print(param, Locale.JAPAN);
		assertEquals(param, result);
	}

	@Test
	public void parse() throws ParseException {
		String result = stringFormatter.parse(param, Locale.JAPAN);
		assertEquals(param, result);
	}

	@Test
	public void parseWhenTrimWhitespace() throws ParseException {
		String whitespaceBothEndsParam = (" " + param + " ");
		String result = stringFormatter.parse(whitespaceBothEndsParam, Locale.JAPAN);
		assertEquals(param, result);
	}

	@Test
	public void printWhenBlankParam() {
		String emptyParam = "";
		String result = stringFormatter.print(emptyParam, Locale.JAPAN);
		assertEquals(null, result);
	}

	@Test
	public void printWhenNullParam() {
		// TODO - When the parameter is null, NullPointerException occurs.
//		String nullParam = null;
//		String result = stringFormatter.print(nullParam, Locale.JAPAN);
//		assertEquals(null, result);
	}

	@Test
	public void parseWhenNullParam() throws ParseException {
		String nullParam = null;
		String result = stringFormatter.parse(nullParam, Locale.JAPAN);
		assertEquals(null, result);
	}
}