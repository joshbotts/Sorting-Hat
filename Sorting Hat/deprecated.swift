//
//  deprecated.swift
//  Sorting Hat
//
//  Created by Joshua Botts on 9/9/20.
//  Copyright © 2020 Joshua Botts. All rights reserved.
//

////
////  ContentView.swift
////  Sorting Hat
////
////  Created by Joshua Botts on 4/15/20.
////  Copyright © 2020 Joshua Botts. All rights reserved.
////
//
//import SwiftUI
//import Combine
//import AVFoundation
//
//struct ContentView: View {
//    @State var userName: String = ""
//    @EnvironmentObject var store: SortingStore
//    @State var storeSet: Bool = false
//    //    @Environment(\.colorScheme) var colorScheme
//    let textFieldPlaceholderText = "Enter your name and press return."
////    @State var kidsMode: Bool = false
//    @ObservedObject private var keyboard = KeyboardResponder()
////    @State var talkingHat: Bool = false
//    @State var settings: Bool = false
//
//    func speakSortingHat() {
//        let utterance = AVSpeechUtterance(string: "Oh, yes. \(self.userName). Let's sort you out.")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//        utterance.rate = 0.3
//
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
//    }
//
//    func textSortingHat() {
//        self.userName = "Ahhhh, yes. Let's sort you out."
//    }
//
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                VStack(alignment: .center) {
//                    Image("sorting-hat")
//                        .resizable()
//                        .scaledToFit()
//                }
//                VStack {
//                    TextField(self.textFieldPlaceholderText, text: self.$userName, onCommit: {
//                        self.store.kidsMode ? self.store.setKidStore(user: self.userName) : self.store.setStore(user: self.userName);
//                        self.storeSet = true
//                        print("User \(self.userName) is set. The Sorting Store has loaded these questions: \(self.store.questions.values.map({$0.question}))")
//                        self.store.talkingHat ? self.speakSortingHat() : self.textSortingHat()
//                    })
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .disableAutocorrection(true)
////                    if self.storeSet == false {
////                        Toggle({
////                            Text("Want to use Kid's Mode?")
////                        }, isOn: self.store.$kidsMode)
////                        .font(.body)
////                        Toggle({
////                            Text("Want the Hat to speak?")
////                        }, isOn: self.store.$talkingHat)
////                        .font(.body)
//                        Button(action: { self.settings = true }, label:  { Image(systemName: "gear") })
////                    }
//                }
//                .padding()
//                .padding(.bottom, keyboard.currentHeight)
//                .edgesIgnoringSafeArea(.bottom)
//                .animation(.easeOut(duration: 0.16))
//                //                .background(colorScheme == .dark ? Color.black : Color.white)
//                HStack {
//                    Spacer()
//                    if self.storeSet == true {
//                        Button("Reset the Sorting Hat",
//                               action: {
//                                self.userName = ""
//                                self.store.resetStore()
//                                self.storeSet = false
//                        }
//                        )
//                            .font(.body)
//                    }
//                }
//                .padding(10)
//                VStack(alignment: .center) {
//                    if self.storeSet == true {
//                        Spacer()
//                        NavigationLink(destination: SortingView(store: self.store, question: self.store.questions.keys.randomElement()!, kidsMode: self.store.kidsMode, talkingHat: self.store.talkingHat)) {
//                            Text("Begin the Sorting!")
//                                .font(.headline)
//                        }
//                        .isDetailLink(false)
//                        //                .background(colorScheme == .dark ? Color.black : Color.white)
//                    }
//                }
//                .padding()
//                .frame(maxWidth: 700, alignment: .center)
//            }
//            .padding()
//        }
//        .padding()
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//class KeyboardResponder: ObservableObject {
//    private var notificationCenter: NotificationCenter
//    @Published private(set) var currentHeight: CGFloat = 0
//
//    init(center: NotificationCenter = .default) {
//        notificationCenter = center
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    deinit {
//        notificationCenter.removeObserver(self)
//    }
//
//    @objc func keyBoardWillShow(notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            currentHeight = keyboardSize.height
//        }
//    }
//
//    @objc func keyBoardWillHide(notification: Notification) {
//        currentHeight = 0
//    }
//}
//
//// implemented view response to keyboard activation from https://stackoverflow.com/a/58242249/12259419

////
////  SceneDelegate.swift
////  Sorting Hat
////
////  Created by Joshua Botts on 4/15/20.
////  Copyright © 2020 Joshua Botts. All rights reserved.
////
//
//import UIKit
//import SwiftUI
//import AVFoundation
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var store = SortingStore()
//    var window: UIWindow?
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
//        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
//        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//
//        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView().environmentObject(store)
//
//        // Use a UIHostingController as window root view controller.
//        if let windowScene = scene as? UIWindowScene {
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(store))
//            self.window = window
//            window.makeKeyAndVisible()
//        }
//
////        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }
//
//
//}
//
//

////
////  AppDelegate.swift
////  Sorting Hat
////
////  Created by Joshua Botts on 4/15/20.
////  Copyright © 2020 Joshua Botts. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(.playback, mode: .moviePlayback)
//        }
//        catch {
//            print("Setting category to AVAudioSessionCategoryPlayback failed.")
//        }
//
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//
//
//}
//

////
////  SortingView.swift
////  Sorting Hat
////
////  Created by Joshua Botts on 5/5/20.
////  Copyright © 2020 Joshua Botts. All rights reserved.
////
//
//import SwiftUI
//import Combine
//import AVFoundation
//import AVKit
//
//struct SortingView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var store: SortingStore
//    @State var sortingTime: Bool = false
//    @State var questionsAsked: Int = 0
//    @State var currentQuestion: Int
//    var kidsMode: Bool
//    var talkingHat: Bool
//    
//    init(store: SortingStore, question: Int, kidsMode: Bool, talkingHat: Bool) {
//        self._currentQuestion = /*State<Int>*/.init(initialValue: question)
//        self.store = store
//        self.kidsMode = kidsMode
//        self.talkingHat = talkingHat
//        print("The Sorting View has received the Sorting Store")
//        print("The current question is \(store.questions[self.currentQuestion]!.question)")
//        print(self.kidsMode ? "The Sorting Hat is in Kid's Mode" : "The Sorting Hat is not in Kid's Mode")
//        print(self.talkingHat ? "The Sorting Hat will automatically speak" : "The Sorting Hat will only speak when asked")
//    }
//    
//    // learned how to initialize a @State wrapped property at https://stackoverflow.com/questions/59920657/swiftui-documentation-for-state-property-wrapper
//    
//    func getQuestion() -> Int {
//        var unaskedQuestions = Dictionary<Int, SortingQuestion>()
//        for question in self.store.questions {
//            if question.value.asked == 0 {
//                unaskedQuestions[question.key] = question.value
//            }
//        }
//        if unaskedQuestions.isEmpty {
//            self.sortingTime = true
//            print("No more unasked questions. Time to sort.")
//        }
//        return unaskedQuestions.randomElement()!.key
//    }
//    
//    func scoreQuestion(choice: SortingQuestion.SortingQuestionChoice) {
//        self.store.questionScorer(user: self.store.user, question: self.store.questions[currentQuestion]!, choice: choice)
//    }
//    
//    func refreshView() {
//        self.questionsAsked += 1
//        var unaskedQuestions: [SortingQuestion] = []
//        for question in self.store.questions.values {
//            if question.asked == 0 {
//                unaskedQuestions.append(question)
//            }
//        }
//        if unaskedQuestions.isEmpty || self.questionsAsked > 4 {
//            self.sortingTime = true
//            print("Time to sort!")
//        } else {
//            self.currentQuestion = self.getQuestion()
//            print("The current question is \(self.store.questions[currentQuestion]?.question ?? "*none*")")
//        }
//    }
//    
//    func sortingResult() -> SortingDestination {
//        print("Sorting scores are: \(String(describing: self.store.user.sortingScores))")
//        return self.store.user.sortingScores!.max(by: { a, b in a.value < b.value })?.key ?? SortingDestination(name: "Error", descriptionFull: "The Sorting Hat needs to be fixed.")
//    }
//    
//    func speakQuestion() {
//        let utterance = AVSpeechUtterance(string: self.store.questions[currentQuestion]!.question)
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//        utterance.rate = 0.3
//        
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
//    }
//    
//    // implemented text to speech thanks to Paul Hudson: https://www.hackingwithswift.com/example-code/media/how-to-convert-text-to-speech-using-avspeechsynthesizer-avspeechutterance-and-avspeechsynthesisvoice
//    
//    func speakChoice(choice: SortingQuestion.SortingQuestionChoice) {
//        let utterance = AVSpeechUtterance(string: choice.choiceText)
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//        utterance.rate = 0.3
//        
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
//    }
//    
//    var body: some View {
//        VStack(alignment: .center) {
//            if sortingTime == false {
//                if kidsMode == true {
//                    VStack {
//                        Button(action: {
//                            self.speakQuestion()
//                        }) {
//                            Text(self.store.questions[currentQuestion]!.question)
//                                .font(.headline)
//                                .lineLimit(nil)
//                                .layoutPriority(1)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .padding(.horizontal, 10)
//                                .padding(.bottom, 20)
//                        }
//                        .lineLimit(nil)
//                        .fixedSize(horizontal: false, vertical: true)
//                    }
//                    ScrollView(.horizontal, showsIndicators: true) {
//                        HStack {
//                            ForEach(self.store.questions[currentQuestion]!.choices, id: \.self.id) { choice in
//                                Button(action: {
//                                    self.scoreQuestion(choice: choice)
//                                    self.refreshView()
//                                })  {
//                                    Image(choice.choiceImage!)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(maxWidth: 300, maxHeight: 300)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                    }
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
//                    .padding(.bottom, 20)
//                } else {
//                    VStack {
//                        VStack {
//                            Button(action: {
//                                self.speakQuestion()
//                            }) {
//                                Text(self.store.questions[currentQuestion]!.question)
//                                    .font(.headline)
//                                    .lineLimit(nil)
//                                    .layoutPriority(1)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                    .padding(.horizontal, 10)
//                                    .padding(.bottom, 20)
//                            }
//                            .lineLimit(nil)
//                            .fixedSize(horizontal: false, vertical: true)
//                        }
//                        ForEach(self.store.questions[currentQuestion]!.choices, id: \.self.id) { choice in
//                            HStack {
//                                Button(choice.choiceText, action: {
//                                    self.scoreQuestion(choice: choice)
//                                    self.refreshView()
//                                })
//                                    .layoutPriority(2)
//                                    .lineLimit(nil)
//                                    .fixedSize(horizontal: false, vertical: true)
//                                Spacer()
//                                if self.talkingHat == true {
//                                    Button(action: {
//                                        self.speakChoice(choice: choice)
//                                    }) { Image(systemName: "speaker.2.fill") }
//                                }
//                            }
//                            .lineLimit(nil)
//                            .fixedSize(horizontal: false, vertical: true)
//                            .padding(.horizontal, 10)
//                            .padding(.bottom, 20)
//                        }
//                    }
//                    .navigationBarHidden(true)
//                    .navigationBarBackButtonHidden(true)
//                    .padding(.bottom, 20)
//                }
//            } else {
//                VStack(alignment: .center) {
//                    if #available(iOS 14, *) {
//                    VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: self.sortingResult().name, withExtension: "mov")!))
//                    } else {
//                    DestinationMovie(player: AVPlayer(url: Bundle.main.url(forResource: self.sortingResult().name, withExtension: "mov")!))
//                    }
//                    Spacer()
//                    Text("\(self.store.user.name), you strike me as a...")
//                    Spacer()
//                    Text(self.sortingResult().name == "Dumbledore's Army" ? "member of \(self.sortingResult().name)!" : "\(self.sortingResult().name)!")
//                    Spacer()
//                    Text(self.sortingResult().descriptionFull)
//                        .font(.caption)
//                        .padding()
//                    Spacer()
//                }
//                .padding()
//                .navigationBarHidden(false)
//                .navigationBarBackButtonHidden(false)
//                .navigationBarItems(leading: Button("Sort Again?") {
//                    self.store.resetStore()
//                    self.presentationMode.wrappedValue.dismiss()
//                })
//            }
//        }
//        .frame(maxWidth: 700, alignment: .center)
//    }
//}
//
//struct DestinationMovie: View, UIViewRepresentable {
//    let player: AVPlayer
//
//    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<DestinationMovie>) {
//        player.play()
//    }
//    func makeUIView(context: Context) -> UIView {
//        return PlayerUIView(player: player)
//    }
//}
//
//// learned how to implement AVPlayer through a SwiftUI View at https://medium.com/flawless-app-stories/avplayer-swiftui-part-2-player-controls-c28b721e7e27
//// tried to also implement a ZStack-overlaid transparent button over the DestinationMovie view to allow users to replay the sorting video, but could not figure out how to set the coordinator object in the DestinationMovie view to allow the player to receive events from the the overlaid button
//
//class PlayerUIView: UIView {
//    let playerLayer = AVPlayerLayer()
//    init(player: AVPlayer) {
//        super.init(frame: .zero)
//
//        playerLayer.player = player
//        layer.addSublayer(playerLayer)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        playerLayer.frame = bounds
//    }
//}
//
//struct SortingView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
