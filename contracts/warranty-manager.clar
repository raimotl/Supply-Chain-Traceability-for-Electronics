;; Warranty Management Contract
;; Handles post-sale service and repairs

(define-map warranties
  { product-id: uint }
  {
    warranty-start: uint,
    warranty-duration: uint,
    warranty-type: (string-utf8 50),
    is-active: bool,
    issuer: principal
  }
)

(define-map service-records
  { product-id: uint, service-id: uint }
  {
    service-date: uint,
    service-type: (string-utf8 50),
    technician: principal,
    description: (string-utf8 200),
    parts-replaced: (list 10 uint),
    is-warranty-service: bool
  }
)

(define-data-var service-counter uint u0)

(define-public (register-warranty
    (product-id uint)
    (warranty-duration uint)
    (warranty-type (string-utf8 50)))
  (begin
    (map-set warranties
      { product-id: product-id }
      {
        warranty-start: block-height,
        warranty-duration: warranty-duration,
        warranty-type: warranty-type,
        is-active: true,
        issuer: tx-sender
      }
    )
    (ok true)
  )
)

(define-public (record-service
    (product-id uint)
    (service-type (string-utf8 50))
    (description (string-utf8 200))
    (parts-replaced (list 10 uint))
    (is-warranty-service bool))
  (let
    (
      (new-service-id (+ (var-get service-counter) u1))
    )
    (var-set service-counter new-service-id)
    (map-set service-records
      { product-id: product-id, service-id: new-service-id }
      {
        service-date: block-height,
        service-type: service-type,
        technician: tx-sender,
        description: description,
        parts-replaced: parts-replaced,
        is-warranty-service: is-warranty-service
      }
    )
    (ok new-service-id)
  )
)

(define-public (void-warranty (product-id uint))
  (let
    (
      (warranty (unwrap-panic (map-get? warranties { product-id: product-id })))
    )
    (asserts! (is-eq (get issuer warranty) tx-sender) (err u403))
    (map-set warranties
      { product-id: product-id }
      (merge warranty { is-active: false })
    )
    (ok true)
  )
)

(define-read-only (get-warranty (product-id uint))
  (map-get? warranties { product-id: product-id })
)

(define-read-only (is-warranty-valid (product-id uint))
  (let
    (
      (warranty (unwrap-panic (map-get? warranties { product-id: product-id })))
    )
    (and
      (get is-active warranty)
      (<= block-height (+ (get warranty-start warranty) (get warranty-duration warranty)))
    )
  )
)

(define-read-only (get-service-record (product-id uint) (service-id uint))
  (map-get? service-records { product-id: product-id, service-id: service-id })
)
