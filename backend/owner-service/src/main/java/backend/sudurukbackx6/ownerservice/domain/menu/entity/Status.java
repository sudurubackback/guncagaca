package backend.sudurukbackx6.ownerservice.domain.menu.entity;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public enum Status {

    ORDERED("주문완료"),
    PREPARING("조리중"),
    DONE("조리완료"),
    CANCELED("주문취소");

    private String status;

    Status(String status) {
        this.status = status;
    }

}
