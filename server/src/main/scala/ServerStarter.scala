import akka.actor._
import com.chaoslabgames.model.GameModelService
import com.chaoslabgames.tcpfront.AkkaNetServerTCP

/**
 * Created by Julia on 13.09.2015.
 */
object ServerStarter extends App {
    val actorSystem = ActorSystem("akka-server")
    val gameModelService = actorSystem.actorOf(Props(new GameModelService()))
    val actorNet    = actorSystem.actorOf(AkkaNetServerTCP.props("127.0.0.1", 8899, gameModelService), "tcp-front")
}




