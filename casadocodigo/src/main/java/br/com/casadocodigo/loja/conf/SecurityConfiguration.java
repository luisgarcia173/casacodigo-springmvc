package br.com.casadocodigo.loja.conf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	private UserDetailsService users;
	
	/**
	 * Responsible for define the URL restrictions
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/produtos/form").hasRole("ADMIN")
			.antMatchers(HttpMethod.POST,"/produtos").hasRole("ADMIN")
			/*.antMatchers("/usuarios/form").hasRole("ADMIN")
			.antMatchers(HttpMethod.POST,"/usuarios").hasRole("ADMIN")*/
			.antMatchers("/usuarios/**").permitAll() //remove and use the above
			.antMatchers("/shopping/**").permitAll()
			.antMatchers("/produtos/**").permitAll()
			.antMatchers("/").permitAll()
			.anyRequest().authenticated()
			.and()
				.formLogin().loginPage("/login").permitAll().failureUrl("/login?to=error")
			    .usernameParameter("username").passwordParameter("password")		
			.and()
			    .logout().logoutSuccessUrl("/login?to=logout")
			.and()
			    .csrf();
	}

	/**
	 * Responsible for igonre the static files [css/js/images]
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/resources/**");
	}
	
	/**
	 * Responsible for user authentication
	 */
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(users).passwordEncoder(new BCryptPasswordEncoder());
	}
	
	
}
