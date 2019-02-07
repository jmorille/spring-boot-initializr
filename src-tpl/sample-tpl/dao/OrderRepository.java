package GROUP_ID.dao;


import GROUP_ID.model.Order;
import org.springframework.data.repository.CrudRepository;

public interface OrderRepository extends CrudRepository<Order, String> { }