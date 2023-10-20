package backend.sudurukbackx6.storeservice.domain.store.service.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class LocateRequest {
	private Double latitude;
	private Double longitude;
}
