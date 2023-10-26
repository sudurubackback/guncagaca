package backend.sudurukbackx6.ownerservice.domain.menu.entity;

public enum Category {

    COFFEE("커피"),
    OTHERS("기타"),
    SMOOTHIE("스무디"),
    AID("에이드"),
    TEA("차"),
    DESSERT("디저트"),
    DRINK("음료");

    private String category;

    Category(String category) {
        this.category = category;
    }

}
