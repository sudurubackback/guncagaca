//package backend.sudurukbackx6.ownerservice.common.config;
//
//import backend.sudurukbackx6.ownerservice.domain.token.config.JwtAuthenticationFilter;
//import backend.sudurukbackx6.ownerservice.domain.token.config.JwtTokenProvider;
//import lombok.RequiredArgsConstructor;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.DelegatingPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.web.SecurityFilterChain;
//import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
//import org.springframework.web.cors.CorsConfiguration;
//import org.springframework.web.cors.CorsConfigurationSource;
//import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
//
//import java.util.Arrays;
//import java.util.HashMap;
//import java.util.Map;
//
//@Configuration
//@RequiredArgsConstructor
//public class SecurityConfig {
//
//
//    // @Bean
//    // public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//    //     //security관련 설정 모두 비활성화
//    //     http.cors().disable()
//    //             .csrf().disable()
//    //             .formLogin().disable()
//    //             .headers().frameOptions().disable();
//    //
//    //     return http.build();
//    // }
//
//
//    private final JwtTokenProvider tokenProvider;
//
//    @Bean
//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//        http
//                .cors(cors -> cors
//                        .configurationSource(corsConfigurationSource()))
//                // CSRF 토큰을 활성화, CSRF 토큰의 생성, 저장, 검증 등은 Spring Security가 자동으로 처리
//                .csrf(csrf -> csrf.disable())
//                .authorizeHttpRequests(authorizeHttpRequests -> authorizeHttpRequests
//                        .antMatchers("/ceo/test", "/ceo/signup", "/ceo/checkemail"
//                                , "/ceo/signin", "/ceo/sendcode", "/ceo/checkcode"
//                                , "/ceo/resetpw", "/ceo/cert").permitAll()
//                        .anyRequest().authenticated()
//                )
//                .addFilterBefore(new JwtAuthenticationFilter(tokenProvider), UsernamePasswordAuthenticationFilter.class)
//                .formLogin(formLogin -> formLogin
//                        .disable())
//                .logout(logout -> logout
//                        .logoutSuccessUrl("/signin")
//                        .permitAll()
//                );
//        return http.build();
//    }
//
//
//
//
//    // password encoder로 사용할 빈 등록
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        PasswordEncoder defaultEncoder = new BCryptPasswordEncoder();
//        String idForEncode = "bcrypt";
//
//        Map<String, PasswordEncoder> encoders = new HashMap<>();
//        encoders.put(idForEncode, defaultEncoder);
//
//        return new DelegatingPasswordEncoder(idForEncode, encoders);
//    }
//
//
//    //CORS 설정
//    @Bean
//    CorsConfigurationSource corsConfigurationSource() {
//        CorsConfiguration configuration = new CorsConfiguration();
//        configuration.setAllowedOrigins(Arrays.asList("http://localhost:8086"));
//        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
//        configuration.setAllowedHeaders(Arrays.asList("Authorization", "content-type", "x-auth-token", "X-CSRF-TOKEN"));
//        configuration.setExposedHeaders(Arrays.asList("x-auth-token"));
//        configuration.setAllowCredentials(true); // 허용된 도메인에 쿠키를 전송하도록 허용
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        source.registerCorsConfiguration("/**", configuration);
//
//        return source;
//    }
//}
