package backend.sudurukbackx6.ownerservice.openAPI.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VendorReqDto {
    private String b_no;
    private String start_dt;
    private String p_nm;
}
