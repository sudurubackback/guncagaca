package backend.sudurukbackx6.ownerservice.domain.menu.entity;

import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.Category;
import backend.sudurukbackx6.ownerservice.domain.menu.entity.enumTypes.StatusMenu;
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

    private String description;

    private Category category;

    private List<OptionsEntity> optionsEntity;

    private StatusMenu status;

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public void setOptionsEntity(List<OptionsEntity> optionsList) {
        this.optionsEntity = optionsList;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public void setStatus(StatusMenu statusMenu) {
        this.status = statusMenu;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
