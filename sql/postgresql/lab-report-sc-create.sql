-- This is a lab report implementation of the FtsContentProvider
-- service contract

select acs_sc_impl__new(
    'FtsContentProvider',	        -- impl_contract_name
    'lr_report',                       -- impl_name
    'lab-report'		        -- impl_owner_name
);

select acs_sc_impl_alias__new(
    'FtsContentProvider',		    -- impl_contract_name
    'lr_report',       	            -- impl_name
    'datasource',			    -- impl_operation_name
    'lab_report::sc::search::datasource',	            -- impl_alias
    'TCL'				    -- impl_pl
);

select acs_sc_impl_alias__new(
    'FtsContentProvider',		    -- impl_contract_name
    'lr_report',	 	            -- impl_name
    'url',				    -- impl_operation_name
    'lab_report::sc::search::url',	                    -- impl_alias
    'TCL'				    -- impl_pl
);


-- Add the binding
select acs_sc_binding__new (
    'FtsContentProvider',
    'lr_report'
);
