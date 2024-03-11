(define-constant contract-owner tx-sender)

(define-constant err-invalid-caller (err u1))

(define-map recipients principal uint)

(define-private (is-valid-caller) (is-eq contract-owner tx-sender))

(define-public (add-recipient (recipient principal) (amount uint)) 
    (begin 
        (asserts! (is-valid-caller) err-invalid-caller) 
        (ok (map-set recipients recipient amount))
    )
)

(define-public (delete-recipient (recipient principal)) 
    (begin (asserts! (is-valid-caller) err-invalid-caller) 
        (ok (map-delete recipients recipient))
    )
)



