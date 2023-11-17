package com.sudurukbackx6.adminservice.common.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;


@Configuration
//@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

//    private final TokenProvider tokenProvider;
//
//    @Bean
//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//        http
//                .cors(cors -> cors
//                        .configurationSource(corsConfigurationSource())
//                )
//                .csrf(csrf -> csrf
//                        .disable()
//                )
//                .authorizeHttpRequests(authorizeHttpRequests -> authorizeHttpRequests
//                        .antMatchers("/admin/signin").permitAll()
//                        .anyRequest().authenticated()
//                )
//                .addFilterBefore(new TokenFilter(tokenProvider), UsernamePasswordAuthenticationFilter.class)
//                .formLogin(formLogin -> formLogin
//                        .disable())
//                .logout(logout -> logout
//                        .logoutSuccessUrl("/signin")
//                        .permitAll()
//                );
//        return http.build();
//    }
//
//    @Bean
//    CorsConfigurationSource corsConfigurationSource() {
//        CorsConfiguration configuration = new CorsConfiguration();
//        configuration.setAllowedOrigins(Arrays.asList("http://localhost:3000", "https://k9d102.p.ssafy.io"));
//        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
//        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type", "X-Requested-With", "Accept", "Origin"));
//        configuration.setAllowCredentials(true);
//
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        source.registerCorsConfiguration("/**", configuration);
//        return source;
//    }
//

    @Bean
    public static PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }
}