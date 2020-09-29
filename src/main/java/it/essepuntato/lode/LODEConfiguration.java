package it.essepuntato.lode;

import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.builder.fluent.Configurations;
import org.apache.commons.configuration2.ex.ConfigurationException;

public class LODEConfiguration {

	private static LODEConfiguration instance = null;

	private String externalURL, webvowl;
	private boolean useHTTPs;

	private LODEConfiguration(String configFile) {
		try {
			Configurations configs = new Configurations();
			Configuration config = configs.properties(configFile);

			externalURL = config.getString("externalURL");
			webvowl = config.getString("webvowl");
			useHTTPs = config.getBoolean("useHTTPs");

		} catch (ConfigurationException e) {
			e.printStackTrace();
		}

	}

	public static LODEConfiguration getInstance(String configFile) {
		if (instance == null) {
			instance = new LODEConfiguration(configFile);
		}
		return instance;
	}

	public String getExternalURL() {
		return externalURL;
	}

	public String getWebvowl() {
		return webvowl;
	}

	public boolean useHTTPs() {
		return useHTTPs;
	}

}
