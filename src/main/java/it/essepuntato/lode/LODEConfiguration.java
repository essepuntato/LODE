package it.essepuntato.lode;

import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.builder.fluent.Configurations;
import org.apache.commons.configuration2.ex.ConfigurationException;

public class LODEConfiguration {

	private static LODEConfiguration instance = null;

	private String externalURL;

	private LODEConfiguration(String configFile) {
		try {
			Configurations configs = new Configurations();
			Configuration config = configs.properties(configFile);

			externalURL = config.getString("externalURL");

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

}
