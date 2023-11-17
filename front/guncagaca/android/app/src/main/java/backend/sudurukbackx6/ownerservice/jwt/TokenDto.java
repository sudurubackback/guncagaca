package backend.sudurukbackx6.ownerservice.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Date;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class TokenDto {
    public String token;
    public Date tokenExpirationTime;
}
