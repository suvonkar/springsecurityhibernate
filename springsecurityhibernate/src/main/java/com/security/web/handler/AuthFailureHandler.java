package com.security.web.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component
public class AuthFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().print("{\"success\": false,\"msg\" : " + getErrorMessage(exception)+ "}");
        response.getWriter().flush();
    }
    
 // customize the error message
 	private String getErrorMessage(AuthenticationException exception) {

 		String error = "";
 		if (exception instanceof BadCredentialsException) {
 			error = "Invalid username and password!";
 		} else if (exception instanceof DisabledException) {
 			error = exception.getMessage();
 		} else {
 			error = "Invalid username and password!";
 		}

 		return error;
 	}
}