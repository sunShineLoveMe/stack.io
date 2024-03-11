(define-constant err-unknown-listing (err u100))

(define-constant err-not-the-maker (err u101))

(define-map listings { id: uint } { name: (string-ascii 50), maker: principal })

(map-set listings {id: u1} {name: "First Listing", maker: tx-sender})
(map-set listings {id: u2} {name: "Second Listing", maker: tx-sender})

(define-read-only (get-listing (id uint)) 
    (map-get? listings {id: id})
)

(define-public (update-name (id uint) (new-name (string-ascii 50))) 
    (
        let (
            (listing (unwrap! (get-listing id) err-unknown-listing))
        )
        (asserts! (is-eq tx-sender (get maker listing)) err-not-the-maker)
		(map-set listings {id: id} (merge listing {name: new-name}))
		(ok true)
    )
)

(print (update-name u1 "New name!"))
(print (update-name u9999 "Nonexistent listing..."))