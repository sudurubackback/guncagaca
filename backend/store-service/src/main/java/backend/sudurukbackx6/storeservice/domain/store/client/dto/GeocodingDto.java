package backend.sudurukbackx6.storeservice.domain.store.client.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
public class GeocodingDto {

    @Getter
    public static class Request {
        private String query;

    }

    @Getter
    public static class Response {
        private String status;
        private List<Address> addresses;
        private String errorMessage;

        @Getter
        public static class Address {
            private String roadAddress;
            private String jibunAddress;
            private String x;
            private String y;
        }
    }

}
