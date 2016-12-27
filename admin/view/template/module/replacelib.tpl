<?php echo $header;?><?php echo $column_left; ?>
<div id="content">

  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
   <?php $class = 'odd'; ?>
  
    <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit"  onclick="$('#form').submit();" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
       <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>

      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>

      </div>
    </div>

 <div class="container-fluid">
 <div class="panel panel-default">
    <div class="content">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form"> 
 


   <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i>  Libraries detected on your installation which can be loaded from google CDN</h3>
   </div>

   <div class="panel-body">
    <table class="list table-responsive" >
   
   <tr>
   <td class="left" colspan="3" style="spacing:70px">
    <div class="scrollbox" style="width: 50%; height:162px; padding: 10px; background:#f6f6f6; overflow-x: hidden; overflow-y: scroll ">

   <?php 
  $checked='';  

   foreach($list as $test){

   
    if($test['status']=='1')
    {
     $checked='checked=checked';
    }
    
   ?>
       <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>" style="height:22px;">
        <input type="checkbox" name="min_js[]" value="<?php echo $test['myfilename']; ?>" <?php echo $checked?> />
                  <?php echo $test['myfilename']; ?>
      </div>
      
        <?php }?>
    </div>
    <br>
     <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a><br><br>
     <div>
     Check to shift to the Google CDN
     </div>
     </td>
    
        <tr style="background: #FFFDBE;border: 1px solid #D4D4D4;">
    <td style="padding:7px;font-size: 14px;vertical-align: top;">
     <div class="cbox" style="padding:10px">
     <?php echo $plugin_description; ?>
          </div>
      </td>
      <td style="padding:7px;font-size: 14px;vertical-align: top;">
     <div class="cbox" style="padding:10px">
     <?php echo $plugin_description1; ?>
          </div>
      </td>
      <td style="padding:7px;font-size: 14px;vertical-align: top;">
     <div class="cbox" style="padding:10px">
     <?php echo $plugin_description2; ?>
          </div>
      </td>
        </tr>   
     </table>
     </tr>
     </div>
      <div align="center">
        <label><a href="http://www.transpacific-software.com/opencart_development_theme_installation_extensions.php">Developed by Transpacific Software</a><br>
           Support:&nbsp&nbsp<a href="http://www.transpacific-software.com/opencart.php">connect@transpacific.in</a>
    </label>
         </div> 
        </div> 
        </div>
        </div>    
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 