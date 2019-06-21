# Deliveries platform iOS
===========================

### Arcitecture

Code follows Clean Swift Architecture.
Clean Swift is Uncle Bob's Clean Architecture applied to iOS.

### Project Structure

    ├─ Scenes (Controllers + Interactors + Presentors + Models + Views )
    ├─ Models (Server + Realm data models)
    ├─ Services (Data managers)
    ├─ Views (UITableViewCell,UICollectionViewCell,...)
    ├─ Globals (Enums,Extentions,...)
    
### Dependencies

Thrid party framewoks and Library are managed using Cocoapods.

### Pods used 
	- pod 'SDWebImage' 
	- pod 'Alamofire'  
        - pod 'RealmSwift' 
