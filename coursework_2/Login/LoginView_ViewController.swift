// VC of the main view of the application

import UIKit
import CoreData

class LoginView_ViewController: UIViewController {
    let defaults = UserDefaults.standard
    let date_helper : DealWithDate = DealWithDate()

    
    
  
    @IBAction func login_noaccount(_ sender: Any) {
        defaults.set("true", forKey: "LoggedIn")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.string(forKey: "Category_uploaded") != nil && defaults.string(forKey: "Category_uploaded") == "true"{
            print("LOADED")
        }
        else{
            
            // population of the predifined categoris 
            print("NO LOADED")
            defaults.set("true", forKey: "Category_uploaded")
            
            
            let color_category : CategoryColor = CategoryColor()
            
            // saving in Core Data
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // create a new entity
            let entity = NSEntityDescription.entity(forEntityName: "Category", in: context)
            
            let newElement = NSManagedObject(entity: entity!, insertInto: context)
            let newElement2 = NSManagedObject(entity: entity!, insertInto: context)
            let newElement3 = NSManagedObject(entity: entity!, insertInto: context)
            let newElement4 = NSManagedObject(entity: entity!, insertInto: context)

            let predifinedGoal : Int32 = 0
            
            let today : Date = date_helper.returnDateForCategoryPopulation()
            let newDate = date_helper.returnOnlyDayMonthYear(inputDate: today)
            
  
            newElement.setValue("exercise", forKey: "name")
            newElement.setValue(color_category.red, forKey: "colour")
            newElement.setValue(predifinedGoal, forKey: "goal")
            newElement.setValue(newDate, forKey: "startDate")

            newElement2.setValue("study", forKey: "name")
            newElement2.setValue(color_category.green, forKey: "colour")
            newElement2.setValue(predifinedGoal, forKey: "goal")
            newElement2.setValue(newDate, forKey: "startDate")

            newElement3.setValue("health", forKey: "name")
            newElement3.setValue(color_category.yellow, forKey: "colour")
            newElement3.setValue(predifinedGoal, forKey: "goal")
            newElement3.setValue(newDate, forKey: "startDate")

            newElement4.setValue("amuse", forKey: "name")
            newElement4.setValue(color_category.blue, forKey: "colour")
            newElement4.setValue(predifinedGoal, forKey: "goal")
            newElement4.setValue(newDate, forKey: "startDate")

            // saving a entity
            do {
                try context.save()
                print("LOADED")
            }catch {print("failed save!")}
            
            
            
        }

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.string(forKey: "LoggedIn") != nil{
            if defaults.string(forKey: "LoggedIn") == "true"{
                performSegue(withIdentifier: "next", sender: nil)
            }
            
        }
    }

}
