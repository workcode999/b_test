<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title"><i class="fa fa-shopping-cart"></i> <?php echo $heading_title; ?></h3>
  </div>
  <div class="table-responsive">
    <table class="table">
      <thead>
        <tr>
          <td class="text-right"><?php echo $column_order_id; ?></td>
          <td><?php echo $column_customer; ?></td>
          <td><?php echo $column_status; ?></td>
          <td><?php echo $column_date_added; ?></td>
          <td class="text-right"><?php echo $column_total; ?></td>
          <td class="text-right"><?php echo $column_action; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php if ($orders) { ?>
        <?php foreach ($orders as $order) { ?>
        <tr>
          <td class="text-right"><?php echo $order['order_id']; ?></td>
          <td><?php echo $order['customer']; ?></td>
					<?php if ($order['status'] == "Shipped") { ?><td class="left"><font color="green"><?php echo $order['status']; ?></font></td>
					
					<?php } elseif ($order['status'] == "Complete") { ?><td class="left"><font color="green"><?php echo $order['status']; ?></font></td>

					<?php } elseif ($order['status'] == "Processing") { ?><td class="left"><font color="blue"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Processed") { ?><td class="left"><font color="blue"><?php echo $order['status']; ?></font></td>

					<?php } elseif ($order['status'] == "Failed") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Canceled") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>				
					<?php } elseif ($order['status'] == "Refunded") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Pending") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Denied") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Expired") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Reversed") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Voided") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>
					<?php } elseif ($order['status'] == "Chargeback") { ?><td class="left"><font color="red"><?php echo $order['status']; ?></font></td>

					<?php } else { ?> <td class="left"><?php echo $order['status']; ?></td>
				<?php } ?>
          <td><?php echo $order['date_added']; ?></td>
          <td class="text-right"><?php echo $order['total']; ?></td>
          <td class="text-right"><a href="<?php echo $order['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
          <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
  </div>
</div>
