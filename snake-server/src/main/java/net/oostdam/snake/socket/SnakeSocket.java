package net.oostdam.snake.socket;

import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ServerEndpoint("/games/{name}")
@ApplicationScoped
public class SnakeSocket {

    private static final Logger LOG = Logger.getLogger(SnakeSocket.class);

    private final Map<String, List<Session>> games =  new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("name") String name) {
        List<Session> sessions = games.get(name);
        if (sessions == null) {
            sessions = new ArrayList<>();
        }
        sessions.add(session);
        games.put(name, sessions);
        LOG.infov("A player joined game: {0}", name);
    }

    @OnClose
    public void onClose(Session session, @PathParam("name") String name) {
        List<Session> sessions = games.get(name);
        sessions.remove(session);
        LOG.infov("A player left game: {0}", name);
    }

    @OnError
    public void onError(Session session, @PathParam("name") String name, Throwable throwable) {
        LOG.error("onError", throwable);
        List<Session> sessions = games.get(name);
        sessions.remove(session);
        LOG.infov("A player left game: {0} due to an error: {1}", name, throwable);
    }

    @OnMessage
    public void onMessage(String message, @PathParam("name") String name) {
        LOG.infov("Received message: [{0}] for game: {1}", message, name);
        List<Session> sessions = games.get(name);
        broadcast(sessions, message);
    }

    private void broadcast(List<Session> sessions, String message) {
        // TODO: exclude sending session?
        sessions.forEach(s -> s.getAsyncRemote().sendObject(message, result -> {
            if (result.getException() != null) {
                LOG.error("Unable to send message.", result.getException());
            }
        }));
    }

}
