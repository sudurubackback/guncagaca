package backend.sudurukbackx6.ownerservice.openAPI.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VenderResDto {
    private int request_cnt;
    private int valid_cnt;
    private String status_code;
}
