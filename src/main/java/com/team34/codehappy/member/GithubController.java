package com.team34.codehappy.member;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

public class GithubController {
	private final static String G_CLIENT_ID = "aa1ce692e109c4381557"; 
	private final static String G_CLIENT_SECRET = "3ef89c7854789938b72bc911a861338c680668dd";
	private final static String G_REDIRECT_URI = "http://localhost:8800/codehappy/githublogin"; 
	public static String getAuthorizationUrl() { 
		String githubUrl = "https://github.com/login/oauth/authorize?" + 
						"client_id=" + G_CLIENT_ID + 
						"&redirect_uri=" + G_REDIRECT_URI + 
						"&response_type=code"; 
		return githubUrl; 
	}
	
	public static JsonNode getAccessToken(String autorize_code){ 
	    final String RequestUrl = "https://github.com/login/oauth/access_token";
	    final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	    postParams.add(new BasicNameValuePair("client_id", G_CLIENT_ID));
	    postParams.add(new BasicNameValuePair("code", autorize_code));    // 로그인 과정중 얻은 code 값
	    postParams.add(new BasicNameValuePair("client_secret", G_CLIENT_SECRET));
	    postParams.add(new BasicNameValuePair("redirect_uri", G_REDIRECT_URI));

	    final HttpClient client = HttpClientBuilder.create().build();
	    final HttpPost post = new HttpPost(RequestUrl);
	    post.addHeader("accept", "application/json");
	    JsonNode returnNode = null;
	    try {
	      post.setEntity(new UrlEncodedFormEntity(postParams));
	      final HttpResponse response = client.execute(post);
	      final int responseCode = response.getStatusLine().getStatusCode();
	      System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
	      System.out.println("Post parameters : " + postParams);
	      System.out.println("Response Code : " + responseCode);
	      //JSON 형태 반환값 처리
	      ObjectMapper mapper = new ObjectMapper();
	      returnNode = mapper.readTree(response.getEntity().getContent());
	    } catch (UnsupportedEncodingException e) {
	      e.printStackTrace();
	    } catch (ClientProtocolException e) {
	      e.printStackTrace();
	    } catch (IOException e) {
	      e.printStackTrace();
	    } finally {
	        // clear resources
	    }
	    return returnNode;
	}
	
	public static JsonNode getGithubUserInfo(JsonNode accessToken) {
		final String RequestUrl = "https://api.github.com/user";
		final HttpClient client = HttpClientBuilder.create().build();
		final HttpGet get = new HttpGet(RequestUrl);
		// add header
		get.addHeader("Authorization", "token " + accessToken.get("access_token").asText());
		JsonNode returnNode = null;
		try {
			final HttpResponse response = client.execute(get);
			// JSON 형태 반환값 처리
			ObjectMapper mapper = new ObjectMapper();
			returnNode = mapper.readTree(response.getEntity().getContent());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// clear resources
		}
		return returnNode;
	}
	
}
