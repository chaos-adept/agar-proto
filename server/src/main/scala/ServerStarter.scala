import akka.actor._
import com.chaoslabgames.model.GameModelService
import com.chaoslabgames.tcpfront.AkkaNetServerTCP

/**
 * Created by Julia on 13.09.2015.
 */
object ServerStarter extends App {

    val serverHost = System.getProperty("SERVER_HOST", "127.0.0.1")
    val serverPort = System.getProperty("SERVER_PORT", "8899").toInt

    val actorSystem = ActorSystem("akka-server")
    val gameModelService = actorSystem.actorOf(Props(new GameModelService()))
    val actorNet    = actorSystem.actorOf(AkkaNetServerTCP.props(serverHost, serverPort, gameModelService), "tcp-front")
}




