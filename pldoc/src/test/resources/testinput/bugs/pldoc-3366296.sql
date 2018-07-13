CREATE OR REPLACE PACKAGE chargerefund_pkg IS
PROCEDURE CreateSGContact(
inIDLanguage IN bc_transactionmsg.IDLanguage%TYPE DEFAULT COALESCE(bc_weboffice_helpers_pkg.grEnvironment.IDLanguage, bc_core_parameters_pkg.ID_NATIONAL_LANGUAGE)
);
END;
