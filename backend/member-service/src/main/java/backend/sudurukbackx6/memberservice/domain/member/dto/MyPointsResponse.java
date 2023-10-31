package backend.sudurukbackx6.memberservice.domain.member.dto;

import lombok.*;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class MyPointsResponse {
    private Long storeId;
    private int point;
    private String name;
    private String img;
}
