<?php echo $header; ?><?php echo (($isOpencartTwo)?$column_left:''); ?>
<div id="content">
<div class="page-header">
    <div class="container-fluid">
       <?php if($isOpencartTwo){ ?><div class="pull-right">
        <button type="submit" form="form-signup" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a>
        </div>
        <?php } ?>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
   <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Edit: <?php echo $heading_title; ?></h3>
        <?php if(!$isOpencartTwo){ ?><div class="pull-right" style="margin-top:-26px;">
        <button type="submit" form="form-signup" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a>
        </div>
        <?php } ?>
      </div>   
    <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-signup">        
          
<?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?><button type="button" class="close" data-dismiss="alert">&times;</button></div>  
      
    
   <?php } ?> 
<div class="alert alert-info inline" style="padding: 5px 15px;">
<div class="radio radio-inline">
<label>
<b>Enable Module:</b> 
</label>
<label>
  <input type="radio" value = "1"  name="mod_enable" <?php if ($isActive == 1) echo 'checked'; ?>>
Yes 
</label>
<label>
  <input type="radio" value = "0"  name="mod_enable" <?php if ($isActive == 0) echo 'checked'; ?>>
No  
</label>

<label>
<b>Default Country</b>
<select name="country_id">
                  <option value="0">--Please Select--</option>
                    <?php foreach ($countries as $country) { ?>
                    <?php if ($country['country_id'] == $modData['def_country']) { ?>
                    <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
              </select>
</label>
<label>
<b>Default State/Region</b>
<select name="zone_id"></select>
</label>
</div>
</div>
<div class="row">
<div class="col-sm-3">
<nav id="login-tabs" class="nav-sidebar">
<ul class="nav nav-tabs tabs-left" id="tab-signup">        
<li><a href="#tab-reg" data-toggle="tab">Register Area</a></li>
<li><a href="#tab-edit" data-toggle="tab">Edit Area</a></li>
<li><a href="#tab-checkout" data-toggle="tab">Payment/Shipping/Guest</a></li>
<li><a href="#tab-mask" data-toggle="tab">Masking/Numeric</a></li>
<li><a href="#tab-misc" data-toggle="tab">Checkout Misc</a></li>
<li><a href="#tab-sort" data-toggle="tab">Sorting</a></li>
<li><a href="#tab-override" data-toggle="tab">Custom CSS-JS</a></li>
<li><a href="#tab-help" data-toggle="tab">Help/Instructions/Docs</a></li> 
</ul>
</nav>                       
</div>
<div class="col-sm-9">
<div class="tab-content">
<div id="tab-reg" class="tab-pane">
<div class="row"><div class="col-md-12">
<div class="table-responsive"><table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left">Register Page Field</td>              
              <td class="left">Show</td>
              <td class="left">Required</td>                            
            </tr>
          </thead>
               <tr>
                  <td class="left">
                   <span data-toggle="tooltip" title="(Account, Address, password will appear in single section)"> Single Section</span>
                  </td>                  
                  <td colspan="2" class="left"> <input type="checkbox" value = "1"  name="single_box" <?php if ($single_box)  echo "checked"; ?>   ></td>                             
               </tr>
               <tr>
                  <td class="left">
                  <span data-toggle="tooltip" title="(On Registration Page Only for faster registration)">Hide All Address Fields</br>(On Registration Page Only for faster registration)</span>
                  </td>                  
                  <td colspan="2" class="left"> <input type="checkbox" value = "1"  name="show_address" <?php if ($modData['show_address'] == 1)  echo "checked"; ?>   ></td>                             
               </tr>
               <tr>
                  <td class="left"> First Name </td>                  
                  <td class="left"> <input type="checkbox" value ="1" name="f_name_show" <?php if ($modData['f_name_show'] >0)  echo "checked"; ?>   ></td>
                  <td class="left"> <input type="checkbox" value = "1"  name="f_name_req"<?php if ($modData['f_name_req'] >0)  echo "checked"; ?>   ></td>            
               </tr>
               <tr>
                  <td class="left"> Last Name </td>                  
                  <td class="left"> <input type="checkbox" value = "1"  name="l_name_show"<?php if ($modData['l_name_show'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="l_name_req"<?php if ($modData['l_name_req'] >0)  echo "checked"; ?>   ></td>          
               </tr>               
               <tr>
                  <td class="left"> Telephone </td>                  
                  <td class="left"> <input type="checkbox" value = "1"  name="mob_show"<?php if ($modData['mob_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="mob_req"<?php if ($modData['mob_req'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Fax </td>
                  <td class="left"> <input type="checkbox" value = "1"  name="fax_show"<?php if ($modData['fax_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1" disabled name="fax_req"<?php if ($modData['fax_req'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Company </td>                   
                  <td class="left"> <input type="checkbox" value = "1"  name="company_show"<?php if ($modData['company_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="company_req"<?php if ($modData['company_req'] >0)  echo "checked"; ?>   ></td>
               </tr>
                <tr class="<?php echo $isOpencartTwo?'hidden':'';?>">
                  <td class="left"> Company ID </td>                   
        <td class="left"> <input type="checkbox" value = "1"  name="companyId_show"<?php if ($modData['companyId_show'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  disabled name="companyId_req"<?php if ($modData['companyId_req'] >0)  echo "checked"; ?>   ></td>
        </tr>
                <tr>
                  <td class="left"> Address1 </td>                   
        <td class="left"> <input type="checkbox" value = "1"  name="address1_show"<?php if ($modData['address1_show'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="address1_req"<?php if ($modData['address1_req'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Address2 </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="address2_show"<?php if ($modData['address2_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="address2_req"<?php if ($modData['address2_req'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> City </td>                
        <td class="left"> <input type="checkbox" value = "1"  name="city_show"<?php if ($modData['city_show'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="city_req"<?php if ($modData['city_req'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> Post Code </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="pin_show"<?php if ($modData['pin_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="pin_req"<?php if ($modData['pin_req'] >0)  echo "checked"; ?>   ></td>
        </tr>
          <tr>
               <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default State">State/Region</span></td>                
        <td class="left"> <input type="checkbox" value = "1"  name="state_show"<?php if ($modData['state_show'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="state_req"<?php if ($modData['state_req'] >0)  echo "checked"; ?>   ></td>
               </tr>             
               <tr>
                  <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default Country">Country</span></td>                   
          <td class="left"> <input type="checkbox" value = "1"  name="country_show"<?php if ($modData['country_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="country_req"<?php if ($modData['country_req'] >0)  echo "checked"; ?>   ></td>
               </tr>          
               <tr>
                  <td class="left"> Password Confirm </td>
          <td class="left"> <input type="checkbox" value = "1"  name="passconf_show"<?php if ($modData['passconf_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1" disabled name="passconf_req"></td>
               </tr>
                <tr>
                  <td class="left"> NewsLetter </td>                  
          <td class="left"> <input type="checkbox" value = "1"  name="subsribe_show"<?php if ($modData['subsribe_show'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1" disabled name="subsribe_req"></td>
               </tr>
</table>
</div></div></div>            
</div>
<div id="tab-edit" class="tab-pane">
<div class="table-responsive">
<table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left">Edit Page Fields</td>              
              <td class="left">Show</td>
              <td class="left">Required</td>                            
            </tr>
          </thead>
               <tr>
                  <td class="left"> First Name </td>                  
                  <td class="left"> <input type="checkbox" value ="1" name="f_name_show_edit" <?php if ($modData['f_name_show_edit'] >0)  echo "checked"; ?>   ></td>
                  <td class="left"> <input type="checkbox" value = "1"  name="f_name_req_edit"<?php if ($modData['f_name_req_edit'] >0)  echo "checked"; ?>   ></td>            
               </tr>
               <tr>
                <td class="left"> Last Name </td>                  
                <td class="left"> <input type="checkbox" value = "1"  name="l_name_show_edit"<?php if ($modData['l_name_show_edit'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="l_name_req_edit"<?php if ($modData['l_name_req_edit'] >0)  echo "checked"; ?>   ></td>        
               </tr>               
               <tr>
                  <td class="left"> Telephone </td>                  
                  <td class="left"> <input type="checkbox" value = "1"  name="mob_show_edit"<?php if ($modData['mob_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="mob_req_edit"<?php if ($modData['mob_req_edit'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Fax </td>
                  <td class="left"> <input type="checkbox" value = "1"  name="fax_show_edit"<?php if ($modData['fax_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1" disabled name="fax_req_edit"<?php if ($modData['fax_req_edit'] >0)  echo "checked"; ?> >  
               </tr>
               <tr>
                  <td class="left"> Company </td>                   
                  <td class="left"> <input type="checkbox" value = "1"  name="company_show_edit"<?php if ($modData['company_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="company_req_edit"<?php if ($modData['company_req_edit'] >0)  echo "checked"; ?>   ></td>
               </tr>
                <tr class="<?php echo $isOpencartTwo?'hidden':'';?>">
                  <td class="left"> Company ID </td>                   
            <td class="left"> <input type="checkbox" value = "1"  name="companyId_show_edit"<?php if ($modData['companyId_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"><input type="checkbox" value = "1"  disabled name="companyId_req_edit"<?php if ($modData['companyId_req_edit'] >0)  echo "checked"; ?>   ></td>
        </tr>
                <tr>
                  <td class="left"> Address1 </td>                   
          <td class="left"> <input type="checkbox" value = "1"  name="address1_show_edit"<?php if ($modData['address1_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="address1_req_edit"<?php if ($modData['address1_req_edit'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Address2 </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="address2_show_edit"<?php if ($modData['address2_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="address2_req_edit"<?php if ($modData['address2_req_edit'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> City </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="city_show_edit"<?php if ($modData['city_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="city_req_edit"<?php if ($modData['city_req_edit'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> Post Code </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="pin_show_edit"<?php if ($modData['pin_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="pin_req_edit"<?php if ($modData['pin_req_edit'] >0)  echo "checked"; ?>   ></td>
        </tr>
          <tr>
                  <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default State">State/Region</span></td>                
          <td class="left"> <input type="checkbox" value = "1"  name="state_show_edit"<?php if ($modData['state_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="state_req_edit"<?php if ($modData['state_req_edit'] >0)  echo "checked"; ?>   ></td>
               </tr>             
               <tr>
                  <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default Country">Country</span></td>                   
          <td class="left"> <input type="checkbox" value = "1"  name="country_show_edit"<?php if ($modData['country_show_edit'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="country_req_edit"<?php if ($modData['country_req_edit'] >0)  echo "checked"; ?>   ></td>
               </tr>
</table>
</div>            
</div>                                  
<div id="tab-checkout" class="tab-pane">
<div class="table-responsive"><table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left">Checkout Page Address & Guest Fields</td>              
              <td class="left">Show</td>
              <td class="left">Required</td>                            
            </tr>
          </thead>
               <tr>
                  <td class="left"> First Name </td>                  
                  <td class="left"> <input type="checkbox" value ="1" name="f_name_show_checkout" <?php if ($modData['f_name_show_checkout'] >0)  echo "checked"; ?>   ></td>
                  <td class="left"> <input type="checkbox" value = "1"  name="f_name_req_checkout"<?php if ($modData['f_name_req_checkout'] >0)  echo "checked"; ?>   ></td>          
               </tr>
               <tr>
                <td class="left"> Last Name </td>                  
                <td class="left"> <input type="checkbox" value = "1"  name="l_name_show_checkout"<?php if ($modData['l_name_show_checkout'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="l_name_req_checkout"<?php if ($modData['l_name_req_checkout'] >0)  echo "checked"; ?>   ></td>      
               </tr>               
               <tr>
                <td class="left"> Telephone </td>                  
        <td class="left"><input type="checkbox" value = "1"  name="mob_show_checkout"<?php if ($modData['mob_show_checkout'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="checkbox" value = "1"  name="mob_req_checkout"<?php if ($modData['mob_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Fax </td>
                  <td class="left"> <input type="checkbox" value = "1"  name="fax_show_checkout"<?php if ($modData['fax_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"><input type="checkbox" value = "1" disabled name="fax_req_checkout"<?php if ($modData['fax_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Company </td>                   
                  <td class="left"> <input type="checkbox" value = "1"  name="company_show_checkout"<?php if ($modData['company_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="company_req_checkout"<?php if ($modData['company_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>
                <tr class="<?php echo $isOpencartTwo?'hidden':'';?>">
                  <td class="left"> Company ID </td>                   
            <td class="left"> <input type="checkbox" value = "1"  name="companyId_show_checkout"<?php if ($modData['companyId_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="companyId_req_checkout"<?php if ($modData['companyId_req_checkout'] >0)  echo "checked"; ?>   ></td>
        </tr>
                <tr>
                  <td class="left"> Address1 </td>                   
          <td class="left"> <input type="checkbox" value = "1"  name="address1_show_checkout"<?php if ($modData['address1_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="address1_req_checkout"<?php if ($modData['address1_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>
               <tr>
                  <td class="left"> Address2 </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="address2_show_checkout"<?php if ($modData['address2_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  disabled name="address2_req_checkout"<?php if ($modData['address2_req_checkout'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> City </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="city_show_checkout"<?php if ($modData['city_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="city_req_checkout"<?php if ($modData['city_req_checkout'] >0)  echo "checked"; ?>   ></td>
        </tr>
               <tr>
                  <td class="left"> Post Code </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="pin_show_checkout"<?php if ($modData['pin_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="pin_req_checkout"<?php if ($modData['pin_req_checkout'] >0)  echo "checked"; ?>   ></td>
        </tr>
          <tr>
                  <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default State">State/Region</span></td>                
          <td class="left"> <input type="checkbox" value = "1"  name="state_show_checkout"<?php if ($modData['state_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="checkbox" value = "1"  name="state_req_checkout"<?php if ($modData['state_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>             
               <tr>
                  <td class="left"><span data-toggle="tooltip" title="You can hide this field, if you have set default Country">Country</span></td>                   
          <td class="left"> <input type="checkbox" value = "1"  name="country_show_checkout"<?php if ($modData['country_show_checkout'] >0)  echo "checked"; ?>   ></td>
          <td class="left"><input type="checkbox" value = "1"  name="country_req_checkout"<?php if ($modData['country_req_checkout'] >0)  echo "checked"; ?>   ></td>
               </tr>
</table>  
</div>          
</div>          
<div id="tab-mask" class="tab-pane">
<div class="table-responsive"><table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left">Nuneric/Masking(Brazil) Fields</td>              
              <td class="left">Numeric</td>
              <td class="left">Masking</td>                            
            </tr>
          </thead>   
          <thead >            
            <tr >
              <td colspan="3" class="text-center">Don't select both masking and numeric</td>
            </tr>
          </thead>                         
               <tr>
                <td class="left"> Telephone </td>                  
        <td class="left"> <input type="checkbox" value = "1"  name="mob_numeric"<?php if ($modData['mob_numeric'] >0)  echo "checked"; ?>   ></td>
        <td class="left"> <input type="text" value = "<?php echo $modData['mob_mask'];?>"  title="Telephone Brasil-(99)9999-9999?9" name="mob_mask"></td>
               </tr>
               <tr>
                  <td class="left"> Fax </td>
                  <td class="left"> <input type="checkbox" value = "1"  name="fax_numeric"<?php if ($modData['fax_numeric'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="text" value = "<?php echo $modData['fax_mask'];?>" name="fax_mask"></td>
               </tr>
               <tr>
                  <td class="left"> Company </td>                   
            <td class="left"> <input type="checkbox" value = "1"  name="company_numeric"<?php if ($modData['company_numeric'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="text" value = "<?php echo $modData['company_mask'];?>" name="company_mask"></td>
        </tr>              
                <tr class="<?php echo $isOpencartTwo?'hidden':'';?>">
                  <td class="left"> Company ID </td>                   
            <td class="left"> <input type="checkbox" value = "1"  name="companyId_numeric"<?php if ($modData['companyId_numeric'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="text" value = "<?php echo $modData['company_id_mask'];?>" name="company_id_mask"></td>
        </tr>                
        <tr class="<?php echo $isOpencartTwo?'hidden':'';?>">
                  <td class="left"> Tax ID </td>                   
            <td class="left"> <input type="checkbox" value = "1"  name="tax_id_numeric"<?php if ($modData['tax_id_numeric'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="text" value = "<?php echo $modData['tax_id_mask'];?>" name="tax_id_mask"></td>
        </tr> 
               <tr>
                  <td class="left"> Post Code </td>                
          <td class="left"> <input type="checkbox" value = "1"  name="pin_numeric"<?php if ($modData['pin_numeric'] >0)  echo "checked"; ?>   ></td>
          <td class="left"> <input type="text" value = "<?php echo $modData['postcode_mask'];?>"  title="Postcode Brasil- 99999-999" name="postcode_mask"></td>
        </tr>         
</table> 
</div>           
</div>
<div id="tab-misc" class="tab-pane">
<div class="table-responsive">
<table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left" style="width:40%;">Field</td>              
              <td class="left" style="width:60%;">Option</td>                                          
            </tr>
          </thead>
               <tr>                          
              <input type="hidden" value = "1"  name="is_responsive"   >                   
              </tr>
              <tr>
              <td class="left" >Show Payment/Shipping Method Comments</td>              
        <td class="left" colspan="3"> <input type="checkbox" value = "1"  name="show_p_method_comment" <?php if ($modData['show_p_method_comment'] >0)  echo "checked"; ?>   >
        <input type="hidden" value = "0"  name="show_s_method_comment"    ></td>
              </tr>
              <tr>                          
              <td class="left" >Show Coupon/Vouchers Block</td>
              <td class="left"> <input type="checkbox" value = "1"  name="cv_show" <?php if ($modData['cv_show'] >0)  echo "checked"; ?>   ></td>
              </tr>
              <tr>                          
              <td class="left" >Show Coupons</td>              
        <td class="left"> <input type="checkbox" value = "1"  name="c_show" <?php if ($modData['c_show'] >0)  echo "checked"; ?>   >
              </tr>
              <tr>                          
              <td class="left" >Show Vouchers</td>              
        <td class="left"> <input type="checkbox" value = "1"  name="v_show" <?php if ($modData['v_show'] >0)  echo "checked"; ?>   >
              </tr>
              <tr>
              <td class="left" >Keep Shipping and Payment address same</td>              
        <td class="left"> <input type="checkbox" value = "1"  name="same_shipping" <?php if ($modData['same_shipping'] >0)  echo "checked"; ?>   >           
              </tr>
              <tr>
              <td class="left" >Override below address format<br/><span class="help">Overrides for all countries.</span></td>              
        <td class="left"> <input type="checkbox" value = "1"  name="override_format" <?php if ($modData['override_format'] >0)  echo "checked"; ?>   >           
              </tr>              
              <tr>
              <td class="left">Address Format<br/>
              <span class="help">
        First Name = {firstname}<br>
        Last Name = {lastname}<br>
        Company = {company}<br>
        Address 1 = {address_1}<br>
        Address 2 = {address_2}<br>
        City = {city}<br>
        Postcode = {postcode}<br>
        Zone = {zone}<br>
        Zone Code = {zone_code}<br>
        Country = {country}<br>
        <b>*For custom_field = {identifier}</b><br>
        * Applicable only for address custom field
        <br><span style="color:red">
        This will update address format for all countries, Alternatively you may put address format in each country <a href="index.php?route=localisation/country&token=<?php echo $token; ?>" target="_newtab">here.</a>
        <br>You may also use the identifier in country page for custom fields.        
        </span>
        </span>
              </td>
              <td class="left"><textarea name="address_format" autocomplete="off" cols="40" rows="15"><?php echo $modData['address_format']; ?></textarea></td>
              </tr>
              <?php if(count($custom_fields)>0){?>
              <tr>
              <td class="left">Available custom fields for address</td>
              <td class="left">
              <?php foreach ($custom_fields as $field) {?>
              <?php echo $field['location']=='address'?'{'.$field['identifier'].'}<br/>':''; ?>             
              <?php }?>
              </td> </tr>
              <?php } ?>                                            
</table>
<table  style="display: none;" class="list">
                  <thead>
                      <tr>
                        <td class="left"> Attribute Length </td>
                        <td class="left"> Minimum </td>
                        <td class="left"> Maximum </td>
                        <td class="left"> Or Fixed Length for Mobiles </td>
                      </tr>
                  </thead>
                  <tr>
                      <td class="left"> Mobile/Telephone  </td>
<td class="left"> <input type="text" name="mob_min" value="<?php echo $modData['mob_min']; ?>"  maxlength="20" /> </td>
<td class="left"> <input type="text" name="mob_max" value="<?php echo $modData['mob_max']; ?>"  maxlength="20" /> </td>
<td class="left"> <input type="text" name="mob_fix" value="<?php echo $modData['mob_fix']; ?>"  maxlength="20" /> </td>
                  </tr>
                  <tr>
                      <td class="left"> Password  </td>
<td class="left"> <input type="text" name="pass_min" value="<?php echo $modData['pass_min']; ?>"  maxlength="20" /> </td>
<td class="left"> <input type="text" name="pass_max" value="<?php echo $modData['pass_max']; ?>"  maxlength="20" /> </td>
<td class="left"> <input type="text" name="pass_fix" value="<?php echo $modData['pass_fix']; ?>"  maxlength="20" /> </td>
                  </tr>          
              </table>            
</div></div>
<div id="tab-sort" class="tab-pane">
<div class="table-responsive">
<table class="table table-striped table-bordered table-hover">
          <thead >            
            <tr >
              <td class="left">Field Order</td>              
              <td class="left">Sort Number</td>                                          
            </tr>
          </thead>
               <tr>
                  <td class="left"> First Name </td>                  
                  <td class="left"> <input type="text" name="f_name_sort" size="1" value="<?php echo $modData['f_name_sort']; ?>"  maxlength="2" /> </td>                             
               </tr>
               <tr>
                  <td class="left"> Last Name </td>                  
                  <td class="left"> <input type="text" name="l_name_sort" size="1" value="<?php echo $modData['l_name_sort']; ?>"  maxlength="2" /> </td>               
               </tr>
               <tr>
                  <td class="left"> Email </td>
                  <td class="left"> <input type="text" name="email_sort" size="1" value="<?php echo $modData['email_sort']; ?>"  maxlength="2" /> </td>                  
               </tr>               
               <tr>
                  <td class="left"> Telephone </td>                  
                  <td class="left"> <input type="text" name="mob_sort" size="1" value="<?php echo $modData['mob_sort']; ?>"  maxlength="2" /> </td>
        </tr>
               <tr>
                  <td class="left"> Fax </td>
                  <td class="left"> <input type="text" name="fax_sort" size="1" value="<?php echo $modData['fax_sort']; ?>"  maxlength="2" /> </td>
         </tr>
               <tr>
                  <td class="left"> Company </td>                   
                  <td class="left"> <input type="text" name="company_sort" size="1" value="<?php echo $modData['company_sort']; ?>"  maxlength="2" /> </td>
         </tr>
         <tr>
                  <td class="left"> Customer Group </td>
                  <td class="left"> <input type="text" name="cgroup_sort" size="1" value="<?php echo $modData['cgroup_sort']; ?>"  maxlength="2" /> </td>
               </tr>
               <tr class="hidden">
                <td class="left"> Company ID </td>                   
        <td class="left"> <input type="text" name="companyId_sort" size="1" value="<?php echo $modData['companyId_sort']; ?>"  maxlength="2" /> </td>       
        </tr>
        <tr class="hidden">
                  <td class="left"> Tax ID </td>
                  <td class="left"> <input type="text" name="taxId_sort" size="1" value="<?php echo $modData['taxId_sort']; ?>"  maxlength="2" /> </td>
        </tr>
                <tr>
                  <td class="left"> Address1 </td>       
          <td class="left"> <input type="text" name="address1_sort" size="1" value="<?php echo $modData['address1_sort']; ?>"  maxlength="2" /> </td>
               </tr>
               <tr>
                  <td class="left"> Address2 </td>                
          <td class="left"> <input type="text" name="address2_sort" size="1" value="<?php echo $modData['address2_sort']; ?>"  maxlength="2" /> </td>         
        </tr>
               <tr>
                  <td class="left"> City </td>                
          <td class="left"> <input type="text" name="city_sort" size="1" value="<?php echo $modData['city_sort']; ?>"  maxlength="2" /> </td>
        </tr>
               <tr>
                  <td class="left"> Post Code </td>                
          <td class="left"> <input type="text" name="pin_sort" size="1" value="<?php echo $modData['pin_sort']; ?>"  maxlength="2" /> </td>
        </tr>
        <tr>
                  <td class="left"> Country </td>                   
          <td class="left"> <input type="text" name="country_sort" size="1" value="<?php echo $modData['country_sort']; ?>"  maxlength="2" /> </td>
               </tr>
          <tr>
                  <td class="left"> State/Region </td>                
          <td class="left"> <input type="text" name="state_sort" size="1" value="<?php echo $modData['state_sort']; ?>"  maxlength="2" /> </td>
               </tr>
               <tr>
                  <td class="left"> Password </td>
                  <td class="left"> <input type="text" name="pass_sort" size="1" value="<?php echo $modData['pass_sort']; ?>"  maxlength="2" /> </td>               
               </tr>      
               <tr>
                  <td class="left"> Password Confirm </td>
          <td class="left"> <input type="text" name="passconf_sort" size="1" value="<?php echo $modData['passconf_sort']; ?>"  maxlength="2" /> </td>
               </tr>
                <tr>
                  <td class="left"> NewsLetter </td>                  
          <td class="left"> <input type="text" name="subscribe_sort" size="1" value="<?php echo $modData['subscribe_sort']; ?>"  maxlength="2" /> </td>
               </tr>
</table>            
</div>
</div>
<div id="tab-override" class="tab-pane">
<div class="table-responsive">
<table class="table table-striped table-bordered table-hover">
    <thead >            
            <tr >
              <td class="center" style="width:100%;">Applicable only on checkout page</td>     
            </tr>
          </thead>
          <tr>
              <td class="center">Custom CSS</td>
              </tr>
              <tr>
              <td><textarea name="css" cols="140" rows="30"><?php echo $modData['css']; ?></textarea></td>
              </tr>
              <tr>
              <td class="center">Custom Javascript</td>
              </tr>
              <tr>
              <td><textarea name="js" cols="140" rows="30"><?php echo $modData['js']; ?></textarea></td>
              </tr>
</table></div>
</div>
<div id="tab-help" class="tab-pane">
<ul class="nav nav-tabs">
  <li class="active"><a href="#help-reg" data-toggle="tab">Register</a></li>
  <li><a href="#help-edit" data-toggle="tab">Edit</a></li>
  <li><a href="#help-checkout" data-toggle="tab">Checkout</a></li>  
  <li><a href="#help-keyp" data-toggle="tab">Key Points</a></li>
  <li><a href="#help-ufeatures" data-toggle="tab">Upcoming Features</a></li>
  <li><a href="#help-support" data-toggle="tab">Support</a></li>
</ul>
<div class="tab-content">
<div class="tab-pane active" id="help-reg">
<table class="table table-striped table-hover">  
<tr><td><ul><li>Remove Unwanted Fields from registration process</li></ul></td></tr>
<tr><td><ul><li>Set Default Country and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Set Default Region and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Register Area changes apply on register page and register tab of checkout page</li></ul></td></tr>
</table>
</div>
<div class="tab-pane" id="help-edit">
<table class="table table-striped table-hover">
<tr><td><ul><li>Remove Unwanted Fields from edit pages</li></ul></td></tr>
<tr><td><ul><li>Set Default Country and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Set Default Region and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Edit Area changes apply on edit personal details and address page for a registered user</li></ul></td></tr>  
</table>
</div>
<div class="tab-pane" id="help-checkout">
<table class="table table-striped table-hover">
<tr><td><ul><li>Remove Unwanted Fields from Checkout pages</li></ul></td></tr>
<tr><td><ul><li>Set Default Country and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Set Default Region and hide from all pages</li></ul></td></tr>
<tr><td><ul><li>Changes on Payment/Shiiping/Guest tab will be applied on checkout page</li></ul></td></tr>
<tr><td><ul><li>Options section on checkout will display only if any of checkbox is checked in Misc tab</li></ul></td></tr>
<tr><td><ul><li>These tabs are coupons, vouchers, Comments and rewards will display if user is eligible</li></ul></td></tr>
<tr><td><ul><li>Shipping and payment address same if checked will display only one address and will automatically be set as both payment and shipping address</li></ul></td></tr>
<tr><td><ul><li>Footer Left will show payment icons, the maximum height for icons is 40px.</li></ul></td></tr>
<tr><td><ul><li>You can upload one image with set height or maximum 7 images of 40px height.</li></ul></td></tr>
<tr><td><ul><li>Images must be named p1.png to p7.png in folder catalog/view/theme/xtensions/image/payment/</li></ul></td></tr>
<tr><td><ul><li>Footer right will automatically display Contact Us link, with store telephone and store email</li></ul></td></tr>
<tr><td><ul><li>Footer bottom will display all your info links separated by |</li></ul></td></tr>
<tr class="info"><td><ul><li><b>Language: </b> Most of the text in checkout is being taken from stock checkout.php of your language folder/checkout</li></ul></td></tr>
<tr class="info"><td><ul><li>And the rest is in catalog/language/yourlanguage/account/xtensions.php, so you should translate that yourself for non english languages</li></ul></td></tr>
<tr class="info"><td><ul><li>You may also change stock checkout.php texts as it suits you. As short texts will add more value, for example Step texts 1. Account 2. Address 3.Payment</li></ul></td></tr>
</table>
</div>
<div class="tab-pane" id="help-keyp">
<table class="table table-striped table-hover">
<tr><td><ul><li>Set telephone, postcode, fax as numeric, It won't take alphabets or any other input</li></ul></td></tr>
<tr><td><ul><li>Set telephone, postcode, fax as masked for Brazil, It won't take alphabets or any other input</li></ul></td></tr>
<tr class="warning"><td><ul><li>Don't set both masking and numeric on a single field</li></ul></td></tr>  
<tr><td><ul><li>Set tooltips for your field for hover over effect-multi-lingual</li></ul></td></tr>
<tr><td><ul><li>To Change tooltips text go to catalog/language/yourlanguage(english)/account/xtensions.php and edit the title_field variables to give your custom messages</li></ul></td></tr>
<tr class="warning"><td><ul><li>To disable the tooltips go to same above file and leave title variables blank i.e $_['title_fieldname']='';</li></ul></td></tr>
<tr><td><ul><li>Sort the fields as you like, Sorting will take effect in combination with default and custom fields</li></ul></td></tr>
<tr><td><ul><li>For Example: If you need to display Email, Telephone, Gender(Custom Field), FirstName give them sort 1,2,3,4</li></ul></td></tr>
</table>
</div>
<div class="tab-pane" id="help-ufeatures">
<table class="table table-striped table-hover">  
<tr><td><ul><li><b> We are determined to make this checkout better and better with days to come</b></li></ul></td></tr>
<tr><td><ul><li>Color schemes for checkout, as of now color schemes are not available in admin, however you may change the css</li></ul></td></tr>
<tr><td><ul><li>Less css with predefined color schemes and upgrading all elements through admin</li></ul></td></tr>
<tr><td><ul><li>Complete registration and checkout framework</li></ul></td></tr>
<tr><td><ul><li>Gift wrap module add on</li></ul></td></tr>
<tr><td><ul><li>Export fields including custom fields add on</li></ul></td></tr>
<tr><td><ul><li>Tooltips for custom field</li></ul></td></tr>
<tr><td><ul><li>Custom fields display in invoice, email, address books and order infos</li></ul></td></tr>
<tr><td><ul><li>Address pattern override which will include custom fields.</li></ul></td></tr>
<tr><td><ul><li>Custom validation rules for custom fields</li></ul></td></tr>
<tr><td><ul><li>Facebook and Google Login</li></ul></td></tr>
<tr><td><ul><li>Some upgrades will come as a free upgrade, and some maybe with add on modules for example Gift Wraps.</li></ul></td></tr>
</table>
</div>
<div class="tab-pane" id="help-support">
<table class="table table-striped table-hover">  
<tr><td><ul><li><b>Support:</b> Facing an Issue OR Pre Sales Questions!!</li></ul></td></tr>
<tr><td><ul><li>We provide customized solution for checkouts at reasonable price, so you may send in your requirements at our support center or email us.</li></ul></td></tr>
<tr><td><ul><li>Send Queries : <a href="http://xtensions.in/support" target="_tab">Support Center</a></li></ul></td></tr>
<tr><td><ul><li>Email Us : <a href="mailto:kwason@outlook.com" target="_tab">kwason@outlook.com</a></li></ul></td></tr>
</table>
</div>
</div>
</div>
</div>
</div>
</div>
</form>
    </div>
  </div>
</div>
</div> 
<script type="text/javascript"><!--
$('#tab-signup a:first').tab('show');
$('select[name=\'country_id\']').bind('change', function() {
  $.ajax({
    url: 'index.php?route=module/signup/country&token=<?php echo $token; ?>&country_id=' + this.value,
    dataType: 'json',
          
    success: function(json) {
      
      
      
      html='';
      if (json['zone'] != '' && undefined !=json['zone']) {
        html = '<option value="999">--Please Select--</option>';
        for (i = 0; i < json['zone'].length; i++) {
              html += '<option value="' + json['zone'][i]['zone_id'] + '"';
            
          if (json['zone'][i]['zone_id'] == '<?php echo $modData['def_state'];?>') {
                html += ' selected="selected"';
            }
  
            html += '>' + json['zone'][i]['name'] + '</option>';
        }
      } else {
        html += '<option value="0" selected="selected">--None--</option>';
      }
      
      $('select[name=\'zone_id\']').html(html);
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('select[name=\'country_id\']').trigger('change');

//--></script>
<style type="text/css">
<!--
.tab-content {
  padding-top: 10px;
}
.tabs-left {
  padding-top: 0px;
  border-right: 1px solid #ddd;
}
.tabs-left>li:first-child{
  border-top: 1px dashed #ccc;
}
.tabs-left>li {
  float: none;
  margin-bottom: 0px;
  margin-right: -1px;
  border-bottom: 1px dashed #ccc;
  background:#D9EEF9;
   
}
.tabs-left>li a{
  color: #337AB7;
}
.tabs-left>li:hover,.tabs-left>li.active>a,
.tabs-left>li.active>a:hover,
.tabs-left>li.active>a:focus {
  border-right-color: transparent;
  border-left: 4px solid #337AB7;
  color: #337AB7;
}
.tabs-left>li>a {
  margin-right: 0;
  display: block;
}
td span[data-toggle="tooltip"]:after{
  font-family: FontAwesome;
  color: #1E91CF;
  content: "\f059";
  margin-left: 4px;
}
.help{
  font-size:10px;
  color:grey;
}
-->
</style>
<?php echo $footer; ?>