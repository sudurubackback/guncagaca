package backend.sudurukbackx6.ownerservice.domain.business.dto.request;

import backend.sudurukbackx6.ownerservice.domain.business.entity.Business;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VendorVailidateReqDto {
    private String email;
    private String business_number; //사업자 번호
    private String owner_name;
    private String open_date;
    private String account_number;  //계좌번호

}
