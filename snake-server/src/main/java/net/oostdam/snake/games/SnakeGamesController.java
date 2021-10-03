package net.oostdam.snake.games;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.ArrayList;
import java.util.List;

@Path("/games")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SnakeGamesController {

    private final List<Game> games = new ArrayList<>();

    @GET
    public List<Game> list() {
        return games;
    }

    @POST
    public List<Game> create(Game game){
        games.add(game);
        return games;
    }
}
