(module const mzscheme
  (require (lib "class.ss")
	   (prefix wx: "kernel.ss"))
  (provide (all-defined))

  ;; default spacing between items.
  (define const-default-spacing 0)
  
  ;; default margins:
  (define const-default-x-margin 2)
  (define const-default-y-margin 2)

  ;; default spacing around edge of panel
  (define const-default-border 0)
  
  ;; the maximum hard-min-width of a gauge
  (define const-max-gauge-length 150)
  
  ;; maximum reasonable minimum width/height
  (define max-min 10000)

  (define side-combo-width (case (system-type)
			     [(windows) 20]
			     [(macosx) 18]
			     [else 16]))
  
  ;; message-box, etc.:
  (define box-width 300)
  
  (define err (current-error-port))
  
  ;; indicates init arg not supplied
  (define no-val (gensym))
  (define (no-val->#f v) (if (eq? v no-val) #f v))

  (define ibeam (make-object wx:cursor% 'ibeam))
  (define arrow-cursor (make-object wx:cursor% 'arrow))

  (define bg-color (wx:get-panel-background))

  (define (scale-color c f)
    (make-object wx:color% 
		 (min 255 (floor (* f (send c red)))) 
		 (min 255 (floor (* f (send c green)))) 
		 (min 255 (floor (* f (send c blue))))))

  (define trans-pen (send (wx:get-the-pen-list) find-or-create-pen "white" 0 'transparent))
  (define light-pen (send (wx:get-the-pen-list) find-or-create-pen (scale-color bg-color #e1.35) 0 'solid))
  (define dark-pen (send (wx:get-the-pen-list) find-or-create-pen (scale-color bg-color #e0.6) 0 'solid)) 
  (define dark-brush (send (wx:get-the-brush-list) find-or-create-brush (scale-color bg-color #e0.8) 'solid))
  
  (define wx-tab-group<%> (interface ()))
  (define wx-group-box<%> (interface ()))
  (define wx-text-editor-canvas<%> (interface ()))
  (define wx-basic-panel<%> (interface ()))
  (define internal-editor<%> (interface ()))
  (define internal-menu<%> (interface ())))