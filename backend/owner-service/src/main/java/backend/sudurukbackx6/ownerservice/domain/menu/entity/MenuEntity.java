package backend.sudurukbackx6.ownerservice.domain.menu.entity;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import javax.persistence.Id;
import java.util.List;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "menu")
public class MenuEntity {
    @Id // 기본pk
    private String id;

    @Column(name = "store_id")
    private Long storeId;

    private String name;

    private int price;

    private String img;

    private Category category;

    private List<OptionsEntity> optionsEntity;


}
