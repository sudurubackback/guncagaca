package backend.sudurukbackx6.ownerservice.domain.owner.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.HashMap;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
public class GetTodaySellingResponse {

    private HashMap<Integer, Integer> todaySelling = new HashMap<>();
}
