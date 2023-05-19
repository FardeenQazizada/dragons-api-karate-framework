package api.runners;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	@Karate.Test

	public Karate runTests() {
		//run() method required path to feature files
		//You can use the tags() method to specify the tags
		return Karate.run("classpath:features").tags("Smoke");
	}

}
