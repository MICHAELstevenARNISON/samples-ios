/*
 * Copyright 2019 Okta, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import OktaAuthSdk
import SVProgressHUD

class AuthBaseViewController: UIViewController {
    
    var status: OktaAuthStatus?
    weak var flowCoordinatorDelegate: AuthFlowCoordinatorProtocol?

    public class func instantiate(with status: OktaAuthStatus?,
                                  flowCoordinatorDelegate: AuthFlowCoordinatorProtocol?,
                                  storyBoardName: String,
                                  viewControllerIdentifier: String) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as! AuthBaseViewController
        viewController.status = status
        viewController.flowCoordinatorDelegate = flowCoordinatorDelegate
        
        return viewController
    }

    override func viewDidLoad() {
         self.navigationItem.setHidesBackButton(true, animated: false)
        SVProgressHUD.setDefaultStyle(.dark)
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func processCancel() {
        status?.cancel()
        self.flowCoordinatorDelegate?.onCancel()
    }
}
