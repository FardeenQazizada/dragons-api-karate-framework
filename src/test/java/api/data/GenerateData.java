package api.data;

public class GenerateData {

	public static String getEmail() {
		String email = "autogenerated";
		String provider = "@tekschool.us";
		int randomNumber = (int) (Math.random() * 10000);
		String autoEmail = email + randomNumber + provider;
		return autoEmail;

	}

}
