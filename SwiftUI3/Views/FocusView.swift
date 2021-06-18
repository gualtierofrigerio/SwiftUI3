//
//  FocusedView.swift
//  SwiftUI3
//
//  Created by Gualtiero Frigerio on 17/06/21.
//

import SwiftUI

fileprivate enum FocusViewField {
    case username
    case password
}

struct FocusView: View {
    var body: some View {
        Form {
            TextField("Enter your name", text: $username)
                .focused($focusField, equals: .username)
            SecureField("Password", text: $password)
                .focused($focusField, equals: .password)
        }
        .onSubmit {
            submit()
        }
        Button {
            login()
        } label: {
            Text("Login")
        }
        Text(message)
    }
    
    @FocusState private var focusField: FocusViewField?
    @State private var message: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    private func checkUsername(_ username: String) -> Bool {
        username.count > 0 ? true : false
    }
    
    private func login() {
        if checkUsername(username) == false {
            focusField = .username
            message = "check username"
        }
        else {
            message = "login ok"
        }
    }
    
    private func submit() {
        guard let field = focusField else {
            return
        }
        switch field {
        case .username:
            focusField = .password
        case .password:
            login()
        }
    }
}

struct FocusView_Previews: PreviewProvider {
    static var previews: some View {
        FocusView()
    }
}
