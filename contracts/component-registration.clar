;; Component Registration Contract
;; Tracks individual parts from manufacturers

(define-data-var last-component-id uint u0)

(define-map components
  { component-id: uint }
  {
    manufacturer: principal,
    part-number: (string-utf8 50),
    description: (string-utf8 100),
    manufacture-date: uint,
    batch-id: (string-utf8 50)
  }
)

(define-public (register-component
    (part-number (string-utf8 50))
    (description (string-utf8 100))
    (batch-id (string-utf8 50)))
  (let
    (
      (new-id (+ (var-get last-component-id) u1))
    )
    (var-set last-component-id new-id)
    (map-set components
      { component-id: new-id }
      {
        manufacturer: tx-sender,
        part-number: part-number,
        description: description,
        manufacture-date: block-height,
        batch-id: batch-id
      }
    )
    (ok new-id)
  )
)

(define-read-only (get-component (component-id uint))
  (map-get? components { component-id: component-id })
)

(define-read-only (get-last-component-id)
  (var-get last-component-id)
)
