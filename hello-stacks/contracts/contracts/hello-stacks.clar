(define-constant contract-owner tx-sender) 
(define-constant err-invalid-caller (err u1))
(define-map recipients principal uint)

(define-private (is-valid-caller) (is-eq contract-owner tx-sender))

(define-public (add-recipient (recipient principal) (amount uint)) 
    (if (is-valid-caller) (ok (map-set  recipients recipient amount)) err-invalid-caller))
(define-public (delete-recipient (recipient principal)) (if (is-valid-caller) (ok (map-delete recipients recipient)) err-invalid-caller)) 



(print (add-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK u500))
(print (delete-recipient 'ST1J4G6RR643BCG8G8SR6M2D9Z9KXT2NJDRK3FBTK))

(define-public (asserts-example (input bool)) 
    (begin 
        (asserts! input (err "the assertion failed"))
        (ok "end of the function"))
)