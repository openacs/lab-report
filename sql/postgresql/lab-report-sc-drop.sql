-- Drop the lab report implementation of the FtsContentProvider
-- service contract

select acs_sc_binding__delete(
    'FtsContentProvider',   -- impl_contract_name
    'lr_report'    -- impl_name
);

select acs_sc_impl__delete(
    'FtsContentProvider',   -- impl_contract_name
    'lr_report'	-- impl_name
);

select acs_sc_impl_alias__delete(
    'FtsContentProvider',   -- impl_contract_name
    'lr_report',   -- impl_name
    'datasource'            -- impl_operation_name
);

select acs_sc_impl_alias__delete(
    'FtsContentProvider',   -- impl_contract_name
    'lr_report',   -- impl_name
    'url'                   -- impl_operation_name
);
