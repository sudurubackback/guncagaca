package backend.sudurukbackx6.ownerservice.domain.menu.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Column;
import java.time.LocalDateTime;
import java.util.List;


@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "options")
public class OptionsEntity {

    @Id
    private String id;

    @DBRef
    private MenuEntity menuEntity;

    @Column(name = "option_name")
    private String optionName;

    @Column(name = "details_options")
    private List<DetailsOptionEntity> detailsOptions;


}
