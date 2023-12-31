package backend.sudurukbackx6.ownerservice.domain.menu.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;


@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class DetailsOptionEntity {

    @Id
    private String id;

    @Column(name = "detail_option_name")
    private String detailOptionName;

    @Column(name = "additional_price")
    private int additionalPrice;

}
