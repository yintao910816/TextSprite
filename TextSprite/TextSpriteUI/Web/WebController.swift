import TGSubmodoules

struct WebControllerInteraction {
    
}

public class WebController: BaseController {
    private var interaction: WebControllerInteraction?

    private var controllerNode: WebControllerNode {
        return self.displayNode as! WebControllerNode
    }

    public override init(context: any AccountContext, navigationBarParameters: NavigationBarParameters?) {
        let navigationBarParameters = NavigationBarParameters(hideBackground: false, hideSeparator: false, hideBadge: true)
        super.init(context: context, navigationBarParameters: navigationBarParameters)
        
        self.title = "网站导航"
        
        self.interaction = WebControllerInteraction()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadDisplayNode() {
        self.displayNode = WebControllerNode(context: self.context, presentationData: self.presentationData, interaction: self.interaction!)
        self.displayNode.view.backgroundColor = .white
        self.displayNodeDidLoad()
    }
    
    public override func containerLayoutUpdated(_ layout: ContainerViewLayout, transition: ContainedViewLayoutTransition) {
        super.containerLayoutUpdated(layout, transition: transition)
        self.controllerNode.containerLayoutUpdated(layout, navigationHeight: 0, transition: transition)
    }
}
