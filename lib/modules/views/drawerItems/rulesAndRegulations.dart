import 'package:five_star_fitness/utils/color.dart';
import 'package:flutter/material.dart';

class RulesAndRegulations extends StatelessWidget {
  const RulesAndRegulations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text('Rules And Regulations',
            style: TextStyle(color: veryLight, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: background,
          iconTheme: IconThemeData(color: veryLight),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                      child: Text(
                    'I agree to abide by the rules of the Club, including the completion of a pre-activity screening questionnaire and / or health/ medical information questionnaire prior to participation in any physical activity at the club. I further agree that all use of the club facilities, programms and services shall be undertaken at my sole risk and that the club shall not liable for any injuries, accidents or death occurring to me, including those resulting from the club\'s negligence. I for myself and on behalf of my ececutors, administrators, heirs and essigns do hereby expressly release, discharge, waive, relinquish and covenant not to sue the club, its affiliates officers, directors, agents of employees out of my participation in, or use of, the club\'s facilities,programes and services.I declare that I have completed club pre-activity screening questionnarie and/ or health/medical information questionnarire and that I am physically able to particpate in physical activity, further more I acknowledge that the club has advised me to obtain a physician\'s clearance in the event this answers on lether the pre-activity screening questionnaire and / or health / medical information questionnaire indicates that I should not participate in a program of physical activity without a physician\'s clearance, or if the club is unsure of my physical health, yet I maintain that I am physically capable to pursuing physical activity in the club.',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: veryLight),
                  )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                      child: Text(
                        'Right the admission are reserved.\nThe club reserves the rights to make change, amend, add delete an rules, regulation and policies as it may deem fit to run the club without any prior notice.\nAll sign, notices posted in the club shall be considered as a part of the rules and regulations.\nThe club reserves rights to charge or amend the charges or fees services an facilities rendered in the club as deemed necessary.\nThe club reserves the rights to close the club, party or fully or curtail its price or facilities temporally in the course of any expansion improvements in the gym premises. The club shall make very effort to finish all work in the minimum time, causing least inconvenience to its members.\nAll belongings, items valuables brought by the member in the club are at their own. The club are not responsible for any loss, damage or theft of the same, and no comensation or liability claim shall be entertained as such. No solicitation, canvassing or any other business or commercial activity, shall be permitted the club premises.....\nNo solicitation, canvasing or any other business of commercial activity, shall be permitted inside the club premises, unless written permission the same is sought and granted by the club.\nAny member who is loud, offersive or bothersome to other members or behaves otherwise in an unbecoming manner or who is cited for intract of rules and regulations my be suspended may be suspended or expelled from the club. In the event of termination of membership the unused portion of any advance payment shall be forfeited to the club.',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: veryLight),
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Center(
                      child: Text(
                          '* Members having any health condition that compromeses the ability participate in exercise should meet the fitness councellor before participating.\n* Member must be property attired on standard workout clothes (i.e.leotards, half sleeves T-shirt, gym shorts, jogging suits, etc.)  while in exercise area. Members shall not be permitted to workout / exercise in shirt, trousers) jeans or formal attire.\n* The club services the rights to refuse to refuse any one who is not properly attend and or personally clean.\n* Members should use a separate clean pair of sport shoes i.e. (cross trainers with non-marking soles) street shoes, sandals. chappals are strickly allowed inside the workout / exercise areas. use of towels in compulsory.\n* Use of the equipment should be as instructd by the exercise counsellor.\n* Return weight to proper rack when finished.\n* No dropping / hanging dumbbells / weight plates on the floor. Members doing so, damages to equipment floor and may cause serious injury to others. Member presenting in doing so despite warning may be suspanded or expelled from the club.\n* During period of peak usage, please limit yourself to a maximum of 15 minutes on any one place of cardio equipment. If you need to perform more than 15 minute of exercise please make use of other equipment so that everyone is given am equal opportunity to pursue their fitness program.\n* Members should not leave sweat on equipment & must use towel to cover and wipe equipment during exercise.\n* No Littering debris (Chewing gum, etc) on the gym floor.\n* Profanity, Shouting, Yelling, screaming is not allowed in the gym\n* Smoking is strickly prohibited in the gym premises\n* Shaving in the gym is strictly forbidden.\n* Use of cell phone is not permitted in workout areas.\n* Belonging may not be left daily lockers overnight, Licks will be cut of a contents / removed. The club does not accept responsibility for items removed from lockers.\n* Use of lockers is at the members own risk. The club does not aecept any liability or responsibility for the contents there in.\n* No members shall solicit and perform personal training service on the premises\n* No members shall bring in any individual to perform personal training premises.\n* Children under age of 12 are not allowed in the workshop area.',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: veryLight),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
