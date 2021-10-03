package net.oostdam.snake.games;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.core.Is.is;

@QuarkusTest
class SnakeGamesControllerTest {

    @Test
    public void testGetGames() {
        given()
                .when().get("/games")
                .then()
                .statusCode(200)
                .body(is("[]"));
    }

    @Test
    public void testPostGame() {
        given()
                .contentType("application/json")
                .body(new Game("ze game!"))
                .when().post("/games")
                .then()
                .statusCode(200)
                .body(is("[{\"name\":\"ze game!\"}]"));
    }
}