import Foundation
/**
 * All elements in the hierarchy that want's to propegate the event must implement this protocol 
 * TODO: Rename to: EventSendable?
 */
typealias IEventSender = EventSendable//Legacy support
protocol EventSendable:class {
    var event:EventCallBack{get set}
    func onEvent(_ event:Event)
}
extension EventSendable{
    /**
     * New
     * 1. Assigns a closure, 
     * 2. event is only passed on if event type match
     */
    func addHandler<T>(_ handler:@escaping (T)->Void){
        event = { argEvent in
            if let e = argEvent as? T {
                handler(e)
            }
        }
    }
    /**
     * New
     */
    func removeHandler<T>(_ handler: inout (T)->Void){
        handler = {event in}//assign empty closure
    }
}
