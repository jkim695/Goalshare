//
//  AddGoal.swift
//  Goalshare tree2
//
//  Created by Josh Chou on 12/20/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore

struct AddGoal: View {
    enum FocusedField {
        case goalTitle
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var keyboardObserver = KeyboardObserver()
    @State private var goalTitle = ""
    @State private var goalDescription = ""
    @State private var goalCompletionDate = Date()
    @State private var show = true
    @State private var complete = false
    @State private var isPhotoLibraryDisplay = false
    @State private var isCameraDisplay = false
    @State public var selectedImage: UIImage?
    @FocusState private var focusedBox: Bool
    @FocusState private var focusedField: FocusedField?
    @State private var sourceType: UIImagePickerController.SourceType? = nil

    @Namespace var namespace
    var textLimit = 16
    var body: some View {
        GeometryReader {_ in
            ZStack {
                Color.clear
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    if (show) {
                        HStack() {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .padding(20)
                            }

                            Spacer()
                        }
                        .offset(y: -15)
                    }
                    Text("          What is your Goal?")
                        .font(.headline)
                        .scaleEffect(1.5)
                    TextField("Enter goal here", text: $goalTitle, axis: .vertical)
                        .lineLimit(2...)
                        .frame(height: 70)
                        .padding()
                        .onReceive(Just(goalTitle)) { _ in limitText(textLimit) }
                    VStack(alignment:.leading, spacing: 40) {
                        DatePicker("Goal Completion Date", selection: $goalCompletionDate, in: Date()..., displayedComponents: .date)
                            .padding()
                        .frame(maxWidth: .infinity)
                        HStack {
                            Spacer()
                            if selectedImage != nil {
                                Image(uiImage: selectedImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle()
                                            .stroke(.black, lineWidth: 4)
                                    }
                            }
                            else {
                                Circle()
                                    .stroke(.black, lineWidth: 4)
                                    .frame(width: 150, height: 150)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                var conditionIsMet = false
                                if (!goalTitle.isEmpty) {
                                    conditionIsMet = true
                                }
                                if conditionIsMet {
                                    let newGoal = Goal(name: goalTitle, date: goalCompletionDate, pin: false)
                                    account.goals.append(newGoal)
                                    
                                    // Add new goal to Firestore
                                    let db = Firestore.firestore()
                                    db.collection("accounts").document(account.id).collection("goals").document(newGoal.id.uuidString).setData([
                                        "name": newGoal.name,
                                        "date": newGoal.date,
                                        "pin": newGoal.pin
                                    ]) { error in
                                        if let error = error {
                                            print("Error adding goal: \(error)")
                                        } else {
                                            print("Goal successfully added!")
                                        }
                                    }
                                    
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    print("Condition not met")
                                }
                            }) {
                                Text("Add Goal!")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .frame(alignment: .trailing)
                            }

                            Spacer()
                        }
                    }
                    Spacer()
                }
                .fullScreenCover(isPresented: self.$isPhotoLibraryDisplay, content: {
                    Camera(selectedImage: self.$selectedImage, sourceType: .photoLibrary)
                        .edgesIgnoringSafeArea(.all)
                })
                .fullScreenCover(isPresented: self.$isCameraDisplay, content: {
                    Camera(selectedImage: self.$selectedImage, sourceType: .camera)
                        .edgesIgnoringSafeArea(.all)
                })
                .padding(.bottom, keyboardObserver.keyboardHeight)
                .ignoresSafeArea(.keyboard)
            }
        }
    }
    func limitText(_ upper: Int) {
        if goalTitle.count > upper {
            goalTitle = String(goalTitle.prefix(upper))
        }
    }
}

// Just for visuals, note id is empty
struct AddGoal_Previews: PreviewProvider {
    static var previews: some View {
        AddGoal()
            .environmentObject(Account(id: ""))
    }
}
