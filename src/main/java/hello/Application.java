package hello;

import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Application {
	private static Logger log = LoggerFactory.getLogger("random-distribution");

	private Random rand = new Random();
	
	@RequestMapping("/")
	public String main() {
		log.info("Called main path");
		return "Choose {/gauss/,/standard} or {gauss/{mean}/{std_dev}, /normal/{mean}/{std_dev}}";
	}

	@RequestMapping({"/gauss", "/standard"})
	public String standardNormal() {
		double normal = rand.nextGaussian();
		log.info("Generated {} with Normal pdf.", normal);
		return "Generated " + normal + " with Normal pdf.";
	}
	
	@RequestMapping({"/gauss/{mean}/{std_dev}", "/normal/{mean}/{std_dev}"})
	public String normal(@PathVariable double mean, @PathVariable double std_dev) {
		double normal = rand.nextGaussian();
		double gauss = mean + normal*Math.abs(std_dev);
		log.info("Generated {} with Gauss(mean={}, sigma={}) pdf.", gauss, mean, std_dev);
		return "Generated " + gauss + " Gauss(mean=" + mean + ", sigma=" + std_dev +") pdf.";
	}
	

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
